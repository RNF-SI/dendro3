// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'essence_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EssenceList {
  List<Essence> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EssenceListCopyWith<EssenceList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EssenceListCopyWith<$Res> {
  factory $EssenceListCopyWith(
          EssenceList value, $Res Function(EssenceList) then) =
      _$EssenceListCopyWithImpl<$Res, EssenceList>;
  @useResult
  $Res call({List<Essence> values});
}

/// @nodoc
class _$EssenceListCopyWithImpl<$Res, $Val extends EssenceList>
    implements $EssenceListCopyWith<$Res> {
  _$EssenceListCopyWithImpl(this._value, this._then);

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
              as List<Essence>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EssenceListImplCopyWith<$Res>
    implements $EssenceListCopyWith<$Res> {
  factory _$$EssenceListImplCopyWith(
          _$EssenceListImpl value, $Res Function(_$EssenceListImpl) then) =
      __$$EssenceListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Essence> values});
}

/// @nodoc
class __$$EssenceListImplCopyWithImpl<$Res>
    extends _$EssenceListCopyWithImpl<$Res, _$EssenceListImpl>
    implements _$$EssenceListImplCopyWith<$Res> {
  __$$EssenceListImplCopyWithImpl(
      _$EssenceListImpl _value, $Res Function(_$EssenceListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$EssenceListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Essence>,
    ));
  }
}

/// @nodoc

class _$EssenceListImpl extends _EssenceList {
  const _$EssenceListImpl({required final List<Essence> values})
      : _values = values,
        super._();

  final List<Essence> _values;
  @override
  List<Essence> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'EssenceList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EssenceListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EssenceListImplCopyWith<_$EssenceListImpl> get copyWith =>
      __$$EssenceListImplCopyWithImpl<_$EssenceListImpl>(this, _$identity);
}

abstract class _EssenceList extends EssenceList {
  const factory _EssenceList({required final List<Essence> values}) =
      _$EssenceListImpl;
  const _EssenceList._() : super._();

  @override
  List<Essence> get values;
  @override
  @JsonKey(ignore: true)
  _$$EssenceListImplCopyWith<_$EssenceListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
