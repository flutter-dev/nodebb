// GENERATED CODE - DO NOT MODIFY BY HAND

part of category;

// **************************************************************************
// Generator: WillsGenerator
// **************************************************************************

class _$Category extends Category {
  int _cid;
  int get cid {
    $observe('cid');
    return _cid;
  }

  set cid(int cid) {
    if (cid == _cid) return;
    _cid = cid;
    $notify('cid');
  }

  String _name;
  String get name {
    $observe('name');
    return _name;
  }

  set name(String name) {
    if (name == _name) return;
    _name = name;
    $notify('name');
  }

  String _bgColor;
  String get bgColor {
    $observe('bgColor');
    return _bgColor;
  }

  set bgColor(String bgColor) {
    if (bgColor == _bgColor) return;
    _bgColor = bgColor;
    $notify('bgColor');
  }

  String _color;
  String get color {
    $observe('color');
    return _color;
  }

  set color(String color) {
    if (color == _color) return;
    _color = color;
    $notify('color');
  }

  String _image;
  String get image {
    $observe('image');
    return _image;
  }

  set image(String image) {
    if (image == _image) return;
    _image = image;
    $notify('image');
  }

  _$Category.$() : super.$();
  factory _$Category({
    int cid,
    String name,
    String bgColor,
    String color,
    String image,
  }) {
    return new _$Category.$()
      .._cid = cid ?? 0
      .._name = name ?? ''
      .._bgColor = bgColor ?? ''
      .._color = color ?? ''
      .._image = image ?? '';
  }
}
