library category;
import 'package:flutter_wills_gen/wills.dart';
import 'package:flutter_wills/flutter_wills.dart';
import 'package:nodebb/utils/utils.dart' as utils;

part 'category.g.dart';

@wills
abstract class Category extends Object with Reactive {

  int cid;

  String name;

  String bgColor;

  String color;

  String image;

  Category.$();

  factory Category.fromJson(Map json) {
    Category category = new _$Category(
      cid: utils.convertToInteger(json['cid']),
      name: json['name'],
      bgColor: json['bgcolor'],
      image: json['img']
    );
    return category;
  }

  factory Category() = _$Category;
}