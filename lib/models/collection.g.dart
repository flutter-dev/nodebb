// GENERATED CODE - DO NOT MODIFY BY HAND

part of collection;

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

class _$Collection<K, E> extends Collection<K, E> {
  @override
  final BuiltMap<K, E> entities;
  @override
  final BuiltList<K> allIds;

  factory _$Collection([void updates(CollectionBuilder<K, E> b)]) =>
      (new CollectionBuilder<K, E>()..update(updates)).build();

  _$Collection._({this.entities, this.allIds}) : super._() {
    if (entities == null)
      throw new BuiltValueNullFieldError('Collection', 'entities');
    if (allIds == null)
      throw new BuiltValueNullFieldError('Collection', 'allIds');
  }

  @override
  Collection<K, E> rebuild(void updates(CollectionBuilder<K, E> b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CollectionBuilder<K, E> toBuilder() =>
      new CollectionBuilder<K, E>()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Collection) return false;
    return entities == other.entities && allIds == other.allIds;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, entities.hashCode), allIds.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Collection')
          ..add('entities', entities)
          ..add('allIds', allIds))
        .toString();
  }
}

class CollectionBuilder<K, E>
    implements Builder<Collection<K, E>, CollectionBuilder<K, E>> {
  _$Collection<K, E> _$v;

  MapBuilder<K, E> _entities;
  MapBuilder<K, E> get entities => _$this._entities ??= new MapBuilder<K, E>();
  set entities(MapBuilder<K, E> entities) => _$this._entities = entities;

  ListBuilder<K> _allIds;
  ListBuilder<K> get allIds => _$this._allIds ??= new ListBuilder<K>();
  set allIds(ListBuilder<K> allIds) => _$this._allIds = allIds;

  CollectionBuilder() {
    if (K == dynamic)
      throw new BuiltValueMissingGenericsError('Collection', 'K');
    if (E == dynamic)
      throw new BuiltValueMissingGenericsError('Collection', 'E');
  }

  CollectionBuilder<K, E> get _$this {
    if (_$v != null) {
      _entities = _$v.entities?.toBuilder();
      _allIds = _$v.allIds?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Collection<K, E> other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Collection<K, E>;
  }

  @override
  void update(void updates(CollectionBuilder<K, E> b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Collection<K, E> build() {
    _$Collection<K, E> _$result;
    try {
      _$result = _$v ??
          new _$Collection<K, E>._(
              entities: entities.build(), allIds: allIds.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'entities';
        entities.build();
        _$failedField = 'allIds';
        allIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Collection', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
