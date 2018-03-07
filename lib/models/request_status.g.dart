// GENERATED CODE - DO NOT MODIFY BY HAND

part of request_status;

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$RequestStatus extends RequestStatus {
  @override
  final RequestStatusType status;
  @override
  final Exception exception;

  factory _$RequestStatus([void updates(RequestStatusBuilder b)]) =>
      (new RequestStatusBuilder()..update(updates)).build();

  _$RequestStatus._({this.status, this.exception}) : super._();

  @override
  RequestStatus rebuild(void updates(RequestStatusBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  RequestStatusBuilder toBuilder() => new RequestStatusBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! RequestStatus) return false;
    return status == other.status && exception == other.exception;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, status.hashCode), exception.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RequestStatus')
          ..add('status', status)
          ..add('exception', exception))
        .toString();
  }
}

class RequestStatusBuilder
    implements Builder<RequestStatus, RequestStatusBuilder> {
  _$RequestStatus _$v;

  RequestStatusType _status;
  RequestStatusType get status => _$this._status;
  set status(RequestStatusType status) => _$this._status = status;

  Exception _exception;
  Exception get exception => _$this._exception;
  set exception(Exception exception) => _$this._exception = exception;

  RequestStatusBuilder();

  RequestStatusBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _exception = _$v.exception;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RequestStatus other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$RequestStatus;
  }

  @override
  void update(void updates(RequestStatusBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$RequestStatus build() {
    final _$result =
        _$v ?? new _$RequestStatus._(status: status, exception: exception);
    replace(_$result);
    return _$result;
  }
}
