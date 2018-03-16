import 'dart:convert';
import 'package:nodebb/application/application.dart';
import 'package:nodebb/socket_io/errors.dart';
import 'package:nodebb/utils/utils.dart' as utils;
import 'package:nodebb/socket_io/eio_parser.dart';

enum SocketIOPacketType { CONNECT, DISCONNECT, EVENT, ACK, ERROR, BINARY_EVENT, BINARY_ACK }

SocketIOPacketType getSocketIOPacketType(int t) {
  SocketIOPacketType type;
  try {
    type = SocketIOPacketType.values[t];
  } catch (e) {
    throw new SocketIOParseException('unsupport socketio packet type ${t}');
  }
  return type;
}

class SocketIOPacket {

  bool useBase64Encoder;

  SocketIOPacketType type;

  String namespace;

  int id;

  int attachments;

  dynamic data;

  SocketIOPacket({this.type, this.data, this.namespace = '/', this.attachments = 0, this.useBase64Encoder = false, this.id});

  @override
  String toString() {
    return '{type: $type, id: $id, data: $data, namespace: $namespace, attachments: $attachments, useBase64Encoder: $useBase64Encoder}';
  }


}

class SocketIOPacketDecoder extends Converter<EngineIOPacket, SocketIOPacket> {

  @override
  SocketIOPacket convert(input) {
    if(input.data is List<int>) {
      List<int> data = input.data;
      SocketIOPacketType type = getSocketIOPacketType(data[0]);
      SocketIOPacket packet = new SocketIOPacket(type: type, data: data.skip(1).toList());
      return packet;
    } else { // String
      String str = input.data;
      int i = 0;
      SocketIOPacketType type = getSocketIOPacketType(utils.convertToInteger(str[0]));
      SocketIOPacket packet = new SocketIOPacket(type: type);
      if (type == SocketIOPacketType.BINARY_EVENT
          || type == SocketIOPacketType.BINARY_ACK) { //get attachments
        StringBuffer _attachments = new StringBuffer();
        while(++i < str.length) {
          if(str[i] == '-') break;
          _attachments.write(str[i]);
        }
        packet.attachments = utils.convertToInteger(_attachments.toString());
        if(packet.attachments == 0 || str[i] != '-') {
          throw new SocketIOParseException('illegal attachments');
        }
      }
      if(i + 1 < str.length) {
        if (str[i + 1] == '/') { //get namespace
          StringBuffer sb = new StringBuffer();
          while (++i < str.length) {
            if (str[i] == ',') break;
            sb.write(str[i]);
          }
          packet.namespace = sb.toString();
        } else {
          packet.namespace = '/';
        }
      }
      if(i + 1 < str.length) {
        int next = str.codeUnitAt(i + 1); //get id
        if (next >= 48 && next <= 57) {
          StringBuffer sb = new StringBuffer();
          while (++i < str.length) {
            next = str.codeUnitAt(i);
            if (!(next >= 48 && next <= 57)) {
              i--;
              break;
            }
            sb.write(str[i]);
          }
          packet.id = utils.convertToInteger(sb.toString());
        }
      }
      if(++i < str.length) {
        try {
          packet.data = JSON.decode(str.substring(i));
        } catch(e) {
          Application.logger.fine('packet data decode fail data: ${str.substring(i)}');
        }
      }
      return packet;
    }
  }

  @override
  Sink<EngineIOPacket> startChunkedConversion(Sink<SocketIOPacket> sink) {
    return new _SocketIOPacketDecoderSink(sink, this);
  }

}

class _SocketIOPacketDecoderSink extends ChunkedConversionSink<EngineIOPacket> {

  Sink _sink;

  SocketIOPacketDecoder _decoder;

  _SocketIOPacketDecoderSink(this._sink, this._decoder);

  SocketIOPacket _pendingPacket;

  List<SocketIOPacket> _buffers = new List();

  void reconstructPendingPacket() {
    reconstruct(obj) {
      if(obj is Map) {
        if (obj.containsKey('_placeholder') &&
            obj.containsKey('num')) { //placeholder
          return _buffers[obj['num']].data;
        } else {
          obj.forEach((key, value) {
            if (value is Map) {
              obj[key] = reconstruct(value);
            }
          });
        }
      } else if(obj is List) {
        for(int i = 0; i < obj.length; i++) {
          obj[i] = reconstruct(obj[i]);
        }
      }
      return obj;
    }
    _pendingPacket.data = reconstruct(_pendingPacket.data);
  }

  @override
  void add(EngineIOPacket chunk) {
    SocketIOPacket packet = this._decoder.convert(chunk);
    if(_pendingPacket != null && packet.data is List<int>) {
      _buffers.add(packet);
      if(_buffers.length == _pendingPacket.attachments) {
        try {
          reconstructPendingPacket();
          this._sink.add(_pendingPacket);
        } catch(e) {
          Application.logger.fine('pending packet reconstruct fail, packet: $_pendingPacket, buffers: $_buffers');
        }
        _pendingPacket = null;
        _buffers.clear();
      }
    }
    if((packet.type == SocketIOPacketType.BINARY_EVENT
        || packet.type == SocketIOPacketType.BINARY_ACK)
        && packet.attachments > 0) { //wait for seq pack
      _pendingPacket = packet;
    } else {
      this._sink.add(packet);
    }
  }

  @override
  void close() {
    this._sink.close();
  }

}

class SocketIOPacketEncoder extends Converter<SocketIOPacket, List<EngineIOPacket>> {

  EngineIOPacket _convertToEngineIOPacket(SocketIOPacket input) {
    StringBuffer sb = new StringBuffer();
    sb.write(input.type.index);
    if(input.type == SocketIOPacketType.BINARY_ACK
        || input.type == SocketIOPacketType.BINARY_EVENT) {
      sb.write(input.attachments);
      sb.write('-');
    }
    if(input.namespace != '/') {
      sb.write(input.namespace);
      sb.write(',');
    }
    if(input.id != null) {
      sb.write(input.id);
    }
    if(input.data != null) {
      sb.write(JSON.encode(input.data));
    }
    return new EngineIOPacket(
        type: EngineIOPacketType.MESSAGE,
        data: sb.toString(),
        useBase64Encoder: input.useBase64Encoder
    );
  }

  List<EngineIOPacket> _destructBinaryPacket(SocketIOPacket packet) {

    List<EngineIOPacket> engineIOPackets = [];

    removeBinary(data) {
      if(data is List<int>) {
        Map placeholder = {'_placholder': true, 'num': engineIOPackets.length};
        engineIOPackets.add(
            new EngineIOPacket(
                type: EngineIOPacketType.MESSAGE,
                data: data
            )
        );
        return placeholder;
      } else if(data is Map) {
        data.forEach((key, value) {
          data[key] = removeBinary(value);
        });
      } else if(data is List) {
        for(int i = 0; i < data.length; i++) {
          data[i] = removeBinary(data[i]);
        }
      }
      return data;
    }
    packet.data = removeBinary(packet.data);
    engineIOPackets.insert(0, _convertToEngineIOPacket(packet));
    return engineIOPackets;
  }

  @override
  List<EngineIOPacket> convert(SocketIOPacket input) {
    List<EngineIOPacket> outs = new List();
    if(input.type == SocketIOPacketType.BINARY_ACK
        || input.type == SocketIOPacketType.BINARY_EVENT) {
      outs.addAll(_destructBinaryPacket(input));
    } else {
      outs.add(_convertToEngineIOPacket(input));
    }
    return outs;
  }

  @override
  Sink<SocketIOPacket> startChunkedConversion(Sink<List<EngineIOPacket>> sink) {
    return new _SocketIOPacketEncoderSink(sink, this);
  }

}

class _SocketIOPacketEncoderSink extends ChunkedConversionSink<SocketIOPacket> {

  Sink _sink;

  SocketIOPacketEncoder _encoder;

  _SocketIOPacketEncoderSink(this._sink, this._encoder);

  @override
  void add(SocketIOPacket chunk) {
    _encoder.convert(chunk).forEach((packet) {
      _sink.add(packet);
    });
  }

  @override
  void close() {
    _sink.close();
  }

}