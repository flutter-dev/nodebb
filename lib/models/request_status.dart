library request_status;
import 'package:built_value/built_value.dart';

part 'request_status.g.dart';

enum RequestStatusType { PENDING, SUCCESS, ERROR }

abstract class RequestStatus implements Built<RequestStatus, RequestStatusBuilder> {

  @nullable
  RequestStatusType get status;

  @nullable
  Exception get exception;

  RequestStatus._();

  factory RequestStatus([updates(RequestStatusBuilder b)]) = _$RequestStatus;
}

bool isRequestResolved(RequestStatusType status) {
  return RequestStatusType.PENDING != status;
}