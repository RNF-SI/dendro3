// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

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
abstract class _$$BmSup30ListImplCopyWith<$Res>
    implements $BmSup30ListCopyWith<$Res> {
  factory _$$BmSup30ListImplCopyWith(
          _$BmSup30ListImpl value, $Res Function(_$BmSup30ListImpl) then) =
      __$$BmSup30ListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BmSup30> values});
}

/// @nodoc
class __$$BmSup30ListImplCopyWithImpl<$Res>
    extends _$BmSup30ListCopyWithImpl<$Res, _$BmSup30ListImpl>
    implements _$$BmSup30ListImplCopyWith<$Res> {
  __$$BmSup30ListImplCopyWithImpl(
      _$BmSup30ListImpl _value, $Res Function(_$BmSup30ListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$BmSup30ListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<BmSup30>,
    ));
  }
}

/// @nodoc

class _$BmSup30ListImpl extends _BmSup30List {
  const _$BmSup30ListImpl({required final List<BmSup30> values})
      : _values = values,
        super._();

  final List<BmSup30> _values;
  @override
  List<BmSup30> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'BmSup30List(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BmSup30ListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BmSup30ListImplCopyWith<_$BmSup30ListImpl> get copyWith =>
      __$$BmSup30ListImplCopyWithImpl<_$BmSup30ListImpl>(this, _$identity);
}

abstract class _BmSup30List extends BmSup30List {
  const factory _BmSup30List({required final List<BmSup30> values}) =
      _$BmSup30ListImpl;
  const _BmSup30List._() : super._();

  @override
  List<BmSup30> get values;
  @override
  @JsonKey(ignore: true)
  _$$BmSup30ListImplCopyWith<_$BmSup30ListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
