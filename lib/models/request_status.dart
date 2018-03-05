library request_status;
import 'package:built_value/built_value.dart';

part 'request_status.g.dart';

enum $RequestStatus { PENDING, SUCCESS, ERROR }

abstract class RequestStatus implements Built<RequestStatus, RequestStatusBuilder> {

  @nullable
  $RequestStatus get status;

  @nullable
  Exception get exception;

  RequestStatus._();

  factory RequestStatus([updates(RequestStatusBuilder b)]) = _$RequestStatus;
}

bool isRequestResolved($RequestStatus status) {
  return $RequestStatus.PENDING != status;
}