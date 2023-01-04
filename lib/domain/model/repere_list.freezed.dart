// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'repere_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RepereList {
  List<Repere> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepereListCopyWith<RepereList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepereListCopyWith<$Res> {
  factory $RepereListCopyWith(
          RepereList value, $Res Function(RepereList) then) =
      _$RepereListCopyWithImpl<$Res, RepereList>;
  @useResult
  $Res call({List<Repere> values});
}

/// @nodoc
class _$RepereListCopyWithImpl<$Res, $Val extends RepereList>
    implements $RepereListCopyWith<$Res> {
  _$RepereListCopyWithImpl(this._value, this._then);

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
              as List<Repere>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RepereListCopyWith<$Res>
    implements $RepereListCopyWith<$Res> {
  factory _$$_RepereListCopyWith(
          _$_RepereList value, $Res Function(_$_RepereList) then) =
      __$$_RepereListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Repere> values});
}

/// @nodoc
class __$$_RepereListCopyWithImpl<$Res>
    extends _$RepereListCopyWithImpl<$Res, _$_RepereList>
    implements _$$_RepereListCopyWith<$Res> {
  __$$_RepereListCopyWithImpl(
      _$_RepereList _value, $Res Function(_$_RepereList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$_RepereList(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Repere>,
    ));
  }
}

/// @nodoc

class _$_RepereList extends _RepereList {
  const _$_RepereList({required final List<Repere> values})
      : _values = values,
        super._();

  final List<Repere> _values;
  @override
  List<Repere> get values {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'RepereList(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RepereList &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RepereListCopyWith<_$_RepereList> get copyWith =>
      __$$_RepereListCopyWithImpl<_$_RepereList>(this, _$identity);
}

abstract class _RepereList extends RepereList {
  const factory _RepereList({required final List<Repere> values}) =
      _$_RepereList;
  const _RepereList._() : super._();

  @override
  List<Repere> get values;
  @override
  @JsonKey(ignore: true)
  _$$_RepereListCopyWith<_$_RepereList> get copyWith =>
      throw _privateConstructorUsedError;
}
