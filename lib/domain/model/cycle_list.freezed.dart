// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cycle_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CycleList {
  List<Cycle> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CycleListCopyWith<CycleList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CycleListCopyWith<$Res> {
  factory $CycleListCopyWith(CycleList value, $Res Function(CycleList) then) =
      _$CycleListCopyWithImpl<$Res, CycleList>;
  @useResult
  $Res call({List<Cycle> values});
}

/// @nodoc
class _$CycleListCopyWithImpl<$Res, $Val extends CycleList>
    implements $CycleListCopyWith<$Res> {
  _$CycleListCopyWithImpl(this._value, this._then);

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
              as List<Cycle>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CycleListImplCopyWith<$Res>
    implements $CycleListCopyWith<$Res> {
  factory _$$CycleListImplCopyWith(
          _$CycleListImpl value, $Res Function(_$CycleListImpl) then) =
      __$$CycleListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Cycle> values});
}

/// @nodoc
class __$$CycleListImplCopyWithImpl<$Res>
    extends _$CycleListCopyWithImpl<$Res, _$CycleListImpl>
    implements _$$CycleListImplCopyWith<$Res> {
  __$$CycleListImplCopyWithImpl(
      _$CycleListImpl _value, $Res Function(_$CycleListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$CycleListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Cycle>,
    ));
  }
}

/// @nodoc

class _$CycleListImpl extends _CycleList {
  const _$CycleListImpl({required final List<Cycle> values})
      : _values = values,
        super._();

  final List<Cycle> _values;
  @override
  List<Cycle> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'CycleList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CycleListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CycleListImplCopyWith<_$CycleListImpl> get copyWith =>
      __$$CycleListImplCopyWithImpl<_$CycleListImpl>(this, _$identity);
}

abstract class _CycleList extends CycleList {
  const factory _CycleList({required final List<Cycle> values}) =
      _$CycleListImpl;
  const _CycleList._() : super._();

  @override
  List<Cycle> get values;
  @override
  @JsonKey(ignore: true)
  _$$CycleListImplCopyWith<_$CycleListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
