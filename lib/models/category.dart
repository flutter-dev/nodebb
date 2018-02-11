library category;
import 'package:built_value/built_value.dart';

part 'category.g.dart';

abstract class Category implements Built<Category, CategoryBuilder> {

  int get cid;

  String get name;

  String get bgColor;

  String get color;

  String get image;

  Category._();
  factory Category([updates(CategoryBuilder b)]) = _$Category;
}