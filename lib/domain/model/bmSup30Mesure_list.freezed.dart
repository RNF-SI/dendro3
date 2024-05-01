// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bmSup30Mesure_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BmSup30MesureList {
  List<BmSup30Mesure> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BmSup30MesureListCopyWith<BmSup30MesureList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BmSup30MesureListCopyWith<$Res> {
  factory $BmSup30MesureListCopyWith(
          BmSup30MesureList value, $Res Function(BmSup30MesureList) then) =
      _$BmSup30MesureListCopyWithImpl<$Res, BmSup30MesureList>;
  @useResult
  $Res call({List<BmSup30Mesure> values});
}

/// @nodoc
class _$BmSup30MesureListCopyWithImpl<$Res, $Val extends BmSup30MesureList>
    implements $BmSup30MesureListCopyWith<$Res> {
  _$BmSup30MesureListCopyWithImpl(this._value, this._then);

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
              as List<BmSup30Mesure>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BmSup30MesureListImplCopyWith<$Res>
    implements $BmSup30MesureListCopyWith<$Res> {
  factory _$$BmSup30MesureListImplCopyWith(_$BmSup30MesureListImpl value,
          $Res Function(_$BmSup30MesureListImpl) then) =
      __$$BmSup30MesureListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BmSup30Mesure> values});
}

/// @nodoc
class __$$BmSup30MesureListImplCopyWithImpl<$Res>
    extends _$BmSup30MesureListCopyWithImpl<$Res, _$BmSup30MesureListImpl>
    implements _$$BmSup30MesureListImplCopyWith<$Res> {
  __$$BmSup30MesureListImplCopyWithImpl(_$BmSup30MesureListImpl _value,
      $Res Function(_$BmSup30MesureListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$BmSup30MesureListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<BmSup30Mesure>,
    ));
  }
}

/// @nodoc

class _$BmSup30MesureListImpl extends _BmSup30MesureList {
  const _$BmSup30MesureListImpl({required final List<BmSup30Mesure> values})
      : _values = values,
        super._();

  final List<BmSup30Mesure> _values;
  @override
  List<BmSup30Mesure> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'BmSup30MesureList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BmSup30MesureListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BmSup30MesureListImplCopyWith<_$BmSup30MesureListImpl> get copyWith =>
      __$$BmSup30MesureListImplCopyWithImpl<_$BmSup30MesureListImpl>(
          this, _$identity);
}

abstract class _BmSup30MesureList extends BmSup30MesureList {
  const factory _BmSup30MesureList(
      {required final List<BmSup30Mesure> values}) = _$BmSup30MesureListImpl;
  const _BmSup30MesureList._() : super._();

  @override
  List<BmSup30Mesure> get values;
  @override
  @JsonKey(ignore: true)
  _$$BmSup30MesureListImplCopyWith<_$BmSup30MesureListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
