import 'dart:async';

import 'package:nodebb/models/models.dart';
import 'package:nodebb/models/room.dart';
import 'package:nodebb/socket_io/socket_io.dart';

class IOService {

 SocketIOClient client;

 Map<String, SocketIOSocket> npSockets = new Map();

 static IOService service = new IOService._();

 IOService._();

 static IOService getInstance() {
   return service;
 }

 setup(SocketIOClient client) {
   this.client = client;
 }

 Future connect({String namespace = '/', Map<String, String> query}) async {
   SocketIOSocket socket = await this.client.of(namespace: namespace, query: query);
   npSockets[namespace] = socket;
 }

 SocketIOSocket getSocket([namespace = '/']) {
   return npSockets[namespace];
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

 Future<Map> getRecentChat({int uid, int after = 0}) {
   Completer completer = new Completer();
   getSocket().send(packet(data: ["modules.chats.getRecentChats",{"uid": uid,"after": after}]), (SocketIOPacket packet) {
     try {
      Map data = packet.data[1];
      List<Room> rooms = new List();
      for(var roomJson in data['rooms']) {
        rooms.add(new Room.fromJson(roomJson));
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
         messages.add(new Message.fromJson(msgJson));
       });
       completer.complete(messages);
     } catch(err) {
       completer.completeError(err);
     }
   });
   return completer.future;
 }

}