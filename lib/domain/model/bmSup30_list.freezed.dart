// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bmSup30_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$BmSup30List {
  List<BmSup30> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BmSup30ListCopyWith<BmSup30List> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BmSup30ListCopyWith<$Res> {
  factory $BmSup30ListCopyWith(
          BmSup30List value, $Res Function(BmSup30List) then) =
      _$BmSup30ListCopyWithImpl<$Res, BmSup30List>;
  @useResult
  $Res call({List<BmSup30> values});
}

/// @nodoc
class _$BmSup30ListCopyWithImpl<$Res, $Val extends BmSup30List>
    implements $BmSup30ListCopyWith<$Res> {
  _$BmSup30ListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<BmSup30>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BmSup30ListCopyWith<$Res>
    implements $BmSup30ListCopyWith<$Res> {
  factory _$$_BmSup30ListCopyWith(
          _$_BmSup30List value, $Res Function(_$_BmSup30List) then) =
      __$$_BmSup30ListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BmSup30> values});
}

/// @nodoc
class __$$_BmSup30ListCopyWithImpl<$Res>
    extends _$BmSup30ListCopyWithImpl<$Res, _$_BmSup30List>
    implements _$$_BmSup30ListCopyWith<$Res> {
  __$$_BmSup30ListCopyWithImpl(
      _$_BmSup30List _value, $Res Function(_$_BmSup30List) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_BmSup30List(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<BmSup30>,
    ));
  }
}

/// @nodoc

class _$_BmSup30List extends _BmSup30List {
  const _$_BmSup30List({required final List<BmSup30> values})
      : _values = values,
        super._();

  final List<BmSup30> _values;
  @override
  List<BmSup30> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'BmSup30List(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BmSup30List &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BmSup30ListCopyWith<_$_BmSup30List> get copyWith =>
      __$$_BmSup30ListCopyWithImpl<_$_BmSup30List>(this, _$identity);
}

abstract class _BmSup30List extends BmSup30List {
  const factory _BmSup30List({required final List<BmSup30> values}) =
      _$_BmSup30List;
  const _BmSup30List._() : super._();

  @override
  List<BmSup30> get values;
  @override
  @JsonKey(ignore: true)
  _$$_BmSup30ListCopyWith<_$_BmSup30List> get copyWith =>
      throw _privateConstructorUsedError;
}
