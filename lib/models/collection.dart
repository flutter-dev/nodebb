library collection;
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'collection.g.dart';

abstract class Collection<K, E> implements Built<Collection<K, E>, CollectionBuilder<K, E>> {

  BuiltMap<K, E> get entities;

  BuiltList<K> get allIds;

  Collection._();

  bool contains(K key) {
    return entities[key] != null;
  }

  E remove(CollectionBuilder b, K key) {
    if(contains(key)) {
      b.entities.update((MapBuilder b) {
        b.remove(key);
      });
      b.allIds.update((ListBuilder b) {
        b.remove(key);
      });
      return entities[key];
    }
    return null;
  }

  void add(CollectionBuilder b, K key, E value) {

    if(b.entities[key] == null) {
      b.allIds.update((ListBuilder b) {
        b.add(key);
      });
    }
    b.entities.remove(key);
    b.entities.putIfAbsent(key, ()=> value);
//    b.entities.update((MapBuilder b) {
//      var newOne = {};
//      newOne[key] = value;
//      b.addAll(newOne);
//    });

  }

  void update(CollectionBuilder b, K key, builder) {
    if(b.entities[key] == null) return;
    Built oldValue = b.entities[key];
    b.entities.remove(key);
    Built newValue = oldValue?.rebuild(builder);
    b.entities.putIfAbsent(key, ()=> newValue);
  }

  factory Collection([updates(CollectionBuilder<K, E> b)]) = _$Collection<K, E>;

}