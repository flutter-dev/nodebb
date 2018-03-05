import 'dart:convert';
import 'package:nodebb/utils/utils.dart' as utils;

enum EngineIOPacketType { OPEN, CLOSE, PING, PONG, MESSAGE, UPGRADE, NOOP }

class EngineIOPacket {

  EngineIOPacketType type;

  bool useBase64Encoder;

  dynamic data;

  EngineIOPacket({this.type, this.data = '', this.useBase64Encoder = false});

  @override
  String toString() {
    return 'EngineIOPacket{type: $type, data: $data}';
  }

}

EngineIOPacketType getEngineIOPacketType(int t) {
  EngineIOPacketType type;
  try {
    type = EngineIOPacketType.values[t];
  } catch (e) {
    throw new StateError(
        'unsupport engineio packet type ${t}');
  }
  return type;
}

class EngineIOPacketDecoder extends Converter<dynamic, EngineIOPacket> {

  @override
  EngineIOPacket convert(input) { //todo binary support
    if(input is String) {
      String _input = input;
      bool _isBase64 = false;
      if('b' == _input[0]) { //base64
        _isBase64 = true;
        _input = _input.substring(1);
      }
      EngineIOPacketType type = getEngineIOPacketType(utils.convertToInteger(_input[0]));
      return new EngineIOPacket(
        type: type,
        data: _isBase64 ? UTF8.decode(BASE64.decode(_input.substring(1))) : _input.substring(1),
//        dataType: EngineIOPacketDataType.STRING
      );
    } else if(input is List<int>) {
      List<int> _input = input;
      EngineIOPacketType type = getEngineIOPacketType(utils.convertToInteger(_input[0]));
      return new EngineIOPacket(
          type: type,
          data: _input.skip(1).toList());
    } else {
      throw new Exception("packet type: ${input.type}, its data type must be List<int> or String, data:${input.data}");
    }
  }

  @override
  Sink<dynamic> startChunkedConversion(Sink<EngineIOPacket> sink) {
    return new _EngineIOPacketDecoderSink(sink, this);
  }

}

class _EngineIOPacketDecoderSink extends ChunkedConversionSink<dynamic> {

  Sink<EngineIOPacket> _sink;

  EngineIOPacketDecoder _decoder;

  _EngineIOPacketDecoderSink(this._sink, this._decoder);

  @override
  void add(chunk) {
    this._sink.add(_decoder.convert(chunk));
  }

  @override
  void close() {
    this._sink.close();
  }

}

class EngineIOPacketEncoder extends Converter<EngineIOPacket, dynamic> {

  @override
  dynamic convert(EngineIOPacket packet) {
    if(packet.data is String) {
      StringBuffer sb = new StringBuffer();
      if(packet.useBase64Encoder) {
        sb.write('b');
      }
      sb.write(packet.type.index);
      if(packet.useBase64Encoder) {
        sb.write(BASE64.encode(UTF8.encode(packet.data)));
      } else {
        sb.write(packet.data);
      }
      return sb.toString();
    } else if(packet.data is List<int>) {
      List<int> data = packet.data;
      data.insert(0, packet.type.index);
      return data;
    } else {
      throw new Exception("packet type: ${packet.type}, its data type must be List<int> or String, data:${packet.data}");
    }
  }

  @override
  Sink<EngineIOPacket> startChunkedConversion(Sink sink) {
    return new _EngineIOPacketEncoderSink(sink, this);
  }

}

class _EngineIOPacketEncoderSink extends ChunkedConversionSink<EngineIOPacket> {

  EngineIOPacketEncoder _encoder;

  Sink _sink;

  _EngineIOPacketEncoderSink(this._sink, this._encoder);

  @override
  void add(EngineIOPacket packet) {
    this._sink.add(_encoder.convert(packet));
  }

  @override
  void close() {
    this._sink.close();
  }

}