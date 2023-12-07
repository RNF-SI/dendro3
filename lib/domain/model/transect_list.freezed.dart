// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transect_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransectList {
  List<Transect> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransectListCopyWith<TransectList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransectListCopyWith<$Res> {
  factory $TransectListCopyWith(
          TransectList value, $Res Function(TransectList) then) =
      _$TransectListCopyWithImpl<$Res, TransectList>;
  @useResult
  $Res call({List<Transect> values});
}

/// @nodoc
class _$TransectListCopyWithImpl<$Res, $Val extends TransectList>
    implements $TransectListCopyWith<$Res> {
  _$TransectListCopyWithImpl(this._value, this._then);

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
              as List<Transect>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransectListCopyWith<$Res>
    implements $TransectListCopyWith<$Res> {
  factory _$$_TransectListCopyWith(
          _$_TransectList value, $Res Function(_$_TransectList) then) =
      __$$_TransectListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Transect> values});
}

/// @nodoc
class __$$_TransectListCopyWithImpl<$Res>
    extends _$TransectListCopyWithImpl<$Res, _$_TransectList>
    implements _$$_TransectListCopyWith<$Res> {
  __$$_TransectListCopyWithImpl(
      _$_TransectList _value, $Res Function(_$_TransectList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_TransectList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Transect>,
    ));
  }
}

/// @nodoc

class _$_TransectList extends _TransectList {
  const _$_TransectList({required final List<Transect> values})
      : _values = values,
        super._();

  final List<Transect> _values;
  @override
  List<Transect> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'TransectList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransectList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransectListCopyWith<_$_TransectList> get copyWith =>
      __$$_TransectListCopyWithImpl<_$_TransectList>(this, _$identity);
}

abstract class _TransectList extends TransectList {
  const factory _TransectList({required final List<Transect> values}) =
      _$_TransectList;
  const _TransectList._() : super._();

  @override
  List<Transect> get values;
  @override
  @JsonKey(ignore: true)
  _$$_TransectListCopyWith<_$_TransectList> get copyWith =>
      throw _privateConstructorUsedError;
}
