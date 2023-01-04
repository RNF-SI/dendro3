// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'regeneration_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegenerationList {
  List<Regeneration> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegenerationListCopyWith<RegenerationList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegenerationListCopyWith<$Res> {
  factory $RegenerationListCopyWith(
          RegenerationList value, $Res Function(RegenerationList) then) =
      _$RegenerationListCopyWithImpl<$Res, RegenerationList>;
  @useResult
  $Res call({List<Regeneration> values});
}

/// @nodoc
class _$RegenerationListCopyWithImpl<$Res, $Val extends RegenerationList>
    implements $RegenerationListCopyWith<$Res> {
  _$RegenerationListCopyWithImpl(this._value, this._then);

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
              as List<Regeneration>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegenerationListCopyWith<$Res>
    implements $RegenerationListCopyWith<$Res> {
  factory _$$_RegenerationListCopyWith(
          _$_RegenerationList value, $Res Function(_$_RegenerationList) then) =
      __$$_RegenerationListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Regeneration> values});
}

/// @nodoc
class __$$_RegenerationListCopyWithImpl<$Res>
    extends _$RegenerationListCopyWithImpl<$Res, _$_RegenerationList>
    implements _$$_RegenerationListCopyWith<$Res> {
  __$$_RegenerationListCopyWithImpl(
      _$_RegenerationList _value, $Res Function(_$_RegenerationList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_RegenerationList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Regeneration>,
    ));
  }
}

/// @nodoc

class _$_RegenerationList extends _RegenerationList {
  const _$_RegenerationList({required final List<Regeneration> values})
      : _values = values,
        super._();

  final List<Regeneration> _values;
  @override
  List<Regeneration> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'RegenerationList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegenerationList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegenerationListCopyWith<_$_RegenerationList> get copyWith =>
      __$$_RegenerationListCopyWithImpl<_$_RegenerationList>(this, _$identity);
}

abstract class _RegenerationList extends RegenerationList {
  const factory _RegenerationList({required final List<Regeneration> values}) =
      _$_RegenerationList;
  const _RegenerationList._() : super._();

  @override
  List<Regeneration> get values;
  @override
  @JsonKey(ignore: true)
  _$$_RegenerationListCopyWith<_$_RegenerationList> get copyWith =>
      throw _privateConstructorUsedError;
}
