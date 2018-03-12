class _BaseException implements Exception {
  final dynamic reason;

  const _BaseException(this.reason);

  String toString() => '${runtimeType}.reason: $reason';
}

class NodeBBLoginFailException extends _BaseException {
  const NodeBBLoginFailException([reason]): super(reason);
}

class RequestFailException extends _BaseException {
  const RequestFailException([reason]): super(reason);
}