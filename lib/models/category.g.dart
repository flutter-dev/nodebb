// GENERATED CODE - DO NOT MODIFY BY HAND

part of category;

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

class _$Category extends Category {
  @override
  final int cid;
  @override
  final String name;
  @override
  final String bgColor;
  @override
  final String color;
  @override
  final String image;

  factory _$Category([void updates(CategoryBuilder b)]) =>
      (new CategoryBuilder()..update(updates)).build();

  _$Category._({this.cid, this.name, this.bgColor, this.color, this.image})
      : super._() {
    if (cid == null) throw new BuiltValueNullFieldError('Category', 'cid');
    if (name == null) throw new BuiltValueNullFieldError('Category', 'name');
    if (bgColor == null)
      throw new BuiltValueNullFieldError('Category', 'bgColor');
    if (color == null) throw new BuiltValueNullFieldError('Category', 'color');
    if (image == null) throw new BuiltValueNullFieldError('Category', 'image');
  }

  @override
  Category rebuild(void updates(CategoryBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoryBuilder toBuilder() => new CategoryBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Category) return false;
    return cid == other.cid &&
        name == other.name &&
        bgColor == other.bgColor &&
        color == other.color &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, cid.hashCode), name.hashCode), bgColor.hashCode),
            color.hashCode),
        image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Category')
          ..add('cid', cid)
          ..add('name', name)
          ..add('bgColor', bgColor)
          ..add('color', color)
          ..add('image', image))
        .toString();
  }
}

class CategoryBuilder implements Builder<Category, CategoryBuilder> {
  _$Category _$v;

  int _cid;
  int get cid => _$this._cid;
  set cid(int cid) => _$this._cid = cid;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _bgColor;
  String get bgColor => _$this._bgColor;
  set bgColor(String bgColor) => _$this._bgColor = bgColor;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  String _image;
  String get image => _$this._image;
  set image(String image) => _$this._image = image;

  CategoryBuilder();

  CategoryBuilder get _$this {
    if (_$v != null) {
      _cid = _$v.cid;
      _name = _$v.name;
      _bgColor = _$v.bgColor;
      _color = _$v.color;
      _image = _$v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Category other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$Category;
  }

  @override
  void update(void updates(CategoryBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Category build() {
    final _$result = _$v ??
        new _$Category._(
            cid: cid, name: name, bgColor: bgColor, color: color, image: image);
    replace(_$result);
    return _$result;
  }
}
