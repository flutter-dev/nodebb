import 'dart:async';

import 'package:nodebb/errors/errors.dart';
import 'package:nodebb/models/models.dart';
import 'package:nodebb/models/room.dart';
import 'package:nodebb/socket_io/socket_io.dart';
import 'package:nodebb/utils/utils.dart' as utils;

//'notificationType_new-topic': data['notificationType_new-topic'],
//'notificationType_new-reply': data['notificationType_new-reply'],
//notificationType_follow: data.notificationType_follow,
//'notificationType_new-chat': data['notificationType_new-chat'],
//'notificationType_group-invite': data['notificationType_group-invite']

enum NodeBBEventType {
  NEW_NOTIFICATION,
  RECEIVE_CHATS,
  UPDATE_UNREAD_CHAT_COUNT,
  UPDATE_NOTIFICATION_COUNT,
  MARKED_AS_READ,
  NEW_POST,
  NEW_TOPIC
}

class NodeBBEvent {

  NodeBBEventType type;

  dynamic data;

  AckHandler ack;

  NodeBBEvent({this.type, this.data, this.ack});

  @override
  String toString() {
    return '{type: $type, data: $data}';
  }
}

class IOService {

 SocketIOClient client;

 Map<String, SocketIOSocket> npSockets = new Map();

 String defaultNamespace = '/';

 StreamController<NodeBBEvent> _eventController = new StreamController.broadcast();

 Stream<NodeBBEvent> get  eventStream  {
   if(!_hasBoundEvents) _bindEvents();
   return _eventController.stream;
 }

 bool _hasBoundEvents = false;

 static IOService service = new IOService._();

 IOService._();

 static IOService getInstance() {
   return service;
 }

 setup(SocketIOClient client) {
   this.client = client;
 }

 Future connect({String namespace = '/', Map<String, String> query}) async {
   SocketIOSocket socket = await client.of(namespace: namespace, query: query);
   npSockets[namespace] = socket;
 }

 SocketIOSocket getSocket([namespace]) {
   return npSockets[namespace ?? defaultNamespace];
 }

 void reset() {
   client.engine.closeAll();
   _hasBoundEvents = false;
   npSockets.clear();
 }

 updateDefaultNamespace([namespace = '/']) {
   String np = defaultNamespace;
   defaultNamespace = namespace;
   return np;
 }

 _bindEvents() {
   if(_hasBoundEvents) return;
   getSocket()?.listen(type: SocketIOSocketEventType.RECEIVE, onData: (SocketIOSocketEvent event) {
      SocketIOPacket packet = event.data;
      if(packet.type == SocketIOPacketType.EVENT) {
        List json = packet.data;
        switch(json[0]) {
          case 'event:chats.markedAsRead':
            _eventController.add(new NodeBBEvent(
              type: NodeBBEventType.MARKED_AS_READ,
              data: json[1],
              ack: () {
                if(event.ack != null) event.ack();
              }
            ));
            break;
          case 'event:chats.receive':
            _eventController.add(new NodeBBEvent(
              type: NodeBBEventType.RECEIVE_CHATS,
              data: json[1],
              ack: () {
                if(event.ack != null) event.ack();
              }
            ));
            break;
          case 'event:unread.updateChatCount':
            _eventController.add(new NodeBBEvent(
              type: NodeBBEventType.UPDATE_UNREAD_CHAT_COUNT,
              data: json[1],
              ack: () {
                if(event.ack != null) event.ack();
              }
            ));
            break;
          case 'event:notifications.updateCount':
            _eventController.add(new NodeBBEvent(
              type: NodeBBEventType.UPDATE_NOTIFICATION_COUNT,
              data: json[1],
              ack: () {
                if(event.ack != null) event.ack();
              }
            ));
            break;
          case 'event:new_notification':
            _eventController.add(new NodeBBEvent(
              type: NodeBBEventType.NEW_NOTIFICATION,
              data: json[1],
              ack: () {
                if(event.ack != null) event.ack();
              }
            ));
            break;
          case 'event:new_post':
            _eventController.add(new NodeBBEvent(
              type: NodeBBEventType.NEW_POST,
              data: json[1],
              ack: () {
                if(event.ack != null) event.ack();
              }
            ));
            break;
          case 'event:new_topic':
            _eventController.add(new NodeBBEvent(
                type: NodeBBEventType.NEW_TOPIC,
                data: json[1],
                ack: () {
                  if(event.ack != null) event.ack();
                }
            ));
            break;
        }
      }
   });
   _hasBoundEvents = true;
 }

 packet({type: SocketIOPacketType.EVENT, data}) {
   return new SocketIOPacket(type: type, data: data);
 }

 Future<UnreadInfo> getUserUnreadCounts() {
   Completer<UnreadInfo> completer = new Completer<UnreadInfo>();
   getSocket().send(packet(data: ["user.getUnreadCounts"]), (SocketIOPacket packet) {
     try {
       Map data = packet.data[1] as Map;
       UnreadInfo info = new UnreadInfo(
         unreadChatCount: data['unreadChatCount'],
         unreadNewTopicCount: data['unreadNewTopicCount'],
         unreadNotificationCount: data['unreadNotificationCount'],
         unreadTopicCount: data['unreadTopicCount'],
         unreadWatchedTopicCount: data['unreadWatchedTopicCount']
       );
       completer.complete(info);
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future<dynamic> getRecentChat({int uid, int after = 0}) {
   Completer completer = new Completer();
   getSocket().send(packet(data: ["modules.chats.getRecentChats",{"uid": uid,"after": after}]), (SocketIOPacket packet) {
     try {
      Map data = packet.data[1];
      List<Room> rooms = new List();
      for(var roomJson in data['rooms']) {
        rooms.add(new Room.fromJSON(roomJson));
      }
      completer.complete({'rooms': rooms, 'nextStart': data['nextStart']});
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future<List<Message>> loadRoom({int roomId, int uid}) {
   Completer<List<Message>> completer = new Completer();
   getSocket().send(packet(data: ["modules.chats.loadRoom",{"roomId": roomId,"uid": uid}]), (SocketIOPacket packet) {
     try {
       Map data = packet.data[1];
       List msgJsons = data['messages'];
       List<Message> messages = new List<Message>();
       msgJsons.forEach((msgJson) {
         messages.add(new Message.fromJSON(msgJson));
       });
       completer.complete(messages);
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future<Message> sendMessage({int roomId, String content}) {
   Completer<Message> completer = new Completer();
   getSocket().send(packet(data: ['modules.chats.send', {"roomId": roomId, "message": content}]), (SocketIOPacket packet) {
     try {
       if(packet.data[0] is Map && packet.data[0]['message'] != null) {
         var reason = packet.data[0]['message'];
         if(reason == '[[error:no-users-in-room]]') {
           throw new NodeBBNoUserInRoomException(reason);
         } else {
           throw new NodeBBException(reason);
         }
       }
       completer.complete(new Message.fromJSON(packet.data[1]));
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 markRead(int roomId) {
   getSocket().send(packet(data: ['modules.chats.markRead', roomId]));
 }

 Future<int> upvote(int topicId, int postId) {
   Completer<int> completer = new Completer<int>();
   getSocket().send(packet(data: ["posts.upvote", {"pid": postId, "room_id": "topic_$topicId"}]), (SocketIOPacket packet) {
     try {
       var data = packet.data[1];
       completer.complete(data['post']['votes']);
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future<Post> reply({int topicId, int postId, String content}) {
   Completer<Post> completer = new Completer();
   getSocket().send(packet(data: ["posts.reply",{"tid": topicId,"content": content,"toPid": postId}]), (SocketIOPacket packet) {
     try {
       var data = packet.data[1];
       data['content'] = content;
       completer.complete(new Post.fromJSON(data));
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future bookmark({int topicId, int postId}) {
   Completer completer = new Completer();
   getSocket().send(packet(data: ["posts.bookmark", {"pid": postId, "room_id": "room_$topicId"}]), (SocketIOPacket packet) {
     try {
        if(packet.data[0] is Map && packet.data[0]['message'] != null) {
          var reason = packet.data[0]['message'];
          if(reason == '[[error:already-bookmarked]]') {
            throw new NodeBBBookmarkedException(reason);
          } else {
            throw new NodeBBException(reason);
          }
        }
        var data = packet.data[1];
        completer.complete(data);
     } catch(err) {
        completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future unbookmark({int topicId, int postId}) {
   Completer completer = new Completer();
   getSocket().send(packet(data: ["posts.unbookmark", {"pid": postId, "room_id": "room_$topicId"}]), (SocketIOPacket packet) {
     try {
       if(packet.data[0] is Map && packet.data[0]['message'] != null) {
         var reason = packet.data[0]['message'];
         throw new NodeBBException(reason);
       }
       completer.complete();
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }


 Future<List<User>> searchUser({String query = ""}) {
   Completer<List<User>> completer = new Completer();
   getSocket().send(packet(data: ["user.search", {"query": query}]), (SocketIOPacket packet) {
     try {
        var data = packet.data[1];
        var results = <User>[];
        if(data['matchCount'] > 0) {
          var users = data['users'] as List;
          users.forEach((json) {
            results.add(new User.fromJSON(json));
          });
        }
        completer.complete(results);
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future<int> hasPrivateChat(int uid) {
   Completer<int> completer = new Completer();
   getSocket().send(packet(data: ["modules.chats.hasPrivateChat", uid]), (SocketIOPacket packet) {
      try {
        var roomId = packet.data[1] ?? -1;
        completer.complete(utils.convertToInteger(roomId));
      } catch(err) {
        completer.completeError(err);
      }
   });
   return completer.future;
 }

 Future<bool> isDnD(int uid) { //用户是否开启免打扰
   Completer<bool> completer = new Completer();
   getSocket().send(packet(data: ["modules.chats.isDnD", uid]), (SocketIOPacket packet) {
     try {
       var isDnD = packet.data[1] ?? false;
       completer.complete(isDnD);
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }
 
 Future<int> newRoom(int uid) {
   Completer<int> completer = new Completer();
   getSocket().send(packet(data: ["modules.chats.newRoom", {"touid": uid}]), (SocketIOPacket packet) {
     try {
       var newRoomId = packet.data[1] ?? -1;
       completer.complete(utils.convertToInteger(newRoomId));
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }
 
 Future leaveRoom(int roomId) {
   Completer completer= new Completer();
   getSocket().send(packet(data: ["modules.chats.leave", roomId]), (SocketIOPacket packet) {
     try {
       if(packet.data[0] == null) {
         completer.complete();
       } else {
         throw new NodeBBException(packet.data[0]);
       }
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

 Future deleteMessage({int roomId, int messageId}) {
   Completer completer= new Completer();
   return completer.future;
 }

 //422["user.setCategorySort","newest_to_oldest"]

}