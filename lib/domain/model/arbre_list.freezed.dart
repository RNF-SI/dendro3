// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arbre_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ArbreList {
  List<Arbre> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ArbreListCopyWith<ArbreList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArbreListCopyWith<$Res> {
  factory $ArbreListCopyWith(ArbreList value, $Res Function(ArbreList) then) =
      _$ArbreListCopyWithImpl<$Res, ArbreList>;
  @useResult
  $Res call({List<Arbre> values});
}

/// @nodoc
class _$ArbreListCopyWithImpl<$Res, $Val extends ArbreList>
    implements $ArbreListCopyWith<$Res> {
  _$ArbreListCopyWithImpl(this._value, this._then);

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
              as List<Arbre>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArbreListImplCopyWith<$Res>
    implements $ArbreListCopyWith<$Res> {
  factory _$$ArbreListImplCopyWith(
          _$ArbreListImpl value, $Res Function(_$ArbreListImpl) then) =
      __$$ArbreListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Arbre> values});
}

/// @nodoc
class __$$ArbreListImplCopyWithImpl<$Res>
    extends _$ArbreListCopyWithImpl<$Res, _$ArbreListImpl>
    implements _$$ArbreListImplCopyWith<$Res> {
  __$$ArbreListImplCopyWithImpl(
      _$ArbreListImpl _value, $Res Function(_$ArbreListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$ArbreListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Arbre>,
    ));
  }
}

/// @nodoc

class _$ArbreListImpl extends _ArbreList {
  const _$ArbreListImpl({required final List<Arbre> values})
      : _values = values,
        super._();

  final List<Arbre> _values;
  @override
  List<Arbre> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'ArbreList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArbreListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArbreListImplCopyWith<_$ArbreListImpl> get copyWith =>
      __$$ArbreListImplCopyWithImpl<_$ArbreListImpl>(this, _$identity);
}

abstract class _ArbreList extends ArbreList {
  const factory _ArbreList({required final List<Arbre> values}) =
      _$ArbreListImpl;
  const _ArbreList._() : super._();

  @override
  List<Arbre> get values;
  @override
  @JsonKey(ignore: true)
  _$$ArbreListImplCopyWith<_$ArbreListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
