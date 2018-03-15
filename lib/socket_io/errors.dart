class _BaseException implements Exception {
  final dynamic reason;

  const _BaseException(this.reason);

  String toString() => '$runtimeType.reason: $reason';
}

class SocketIOStateException extends _BaseException {
  const SocketIOStateException([reason]): super(reason);
}

class SocketIOParseException extends _BaseException {
  const SocketIOParseException([reason]): super(reason);
}