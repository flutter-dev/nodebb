class _BaseException implements Exception {
  final dynamic reason;

  const _BaseException(this.reason);

  String toString() => '$runtimeType.reason: $reason';
}

class NodeBBLoginFailException extends _BaseException {
  const NodeBBLoginFailException([reason]): super(reason);
}

//class RequestFailException extends _BaseException {
//  const RequestFailException([reason]): super(reason);
//}

class NodeBBServiceNotAvailableException extends _BaseException {
  const NodeBBServiceNotAvailableException([reason]): super(reason);
}

class NodeBBException extends _BaseException {
  const NodeBBException([reason]): super(reason);
}

class NodeBBBookmarkedException extends _BaseException {
  const NodeBBBookmarkedException([reason]): super(reason);
}

class ApplicationException extends _BaseException {
  const ApplicationException([reason]): super(reason);
}