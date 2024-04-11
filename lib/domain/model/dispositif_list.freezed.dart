// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispositif_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DispositifList {
  List<Dispositif> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DispositifListCopyWith<DispositifList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DispositifListCopyWith<$Res> {
  factory $DispositifListCopyWith(
          DispositifList value, $Res Function(DispositifList) then) =
      _$DispositifListCopyWithImpl<$Res, DispositifList>;
  @useResult
  $Res call({List<Dispositif> values});
}

/// @nodoc
class _$DispositifListCopyWithImpl<$Res, $Val extends DispositifList>
    implements $DispositifListCopyWith<$Res> {
  _$DispositifListCopyWithImpl(this._value, this._then);

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
              as List<Dispositif>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DispositifListImplCopyWith<$Res>
    implements $DispositifListCopyWith<$Res> {
  factory _$$DispositifListImplCopyWith(_$DispositifListImpl value,
          $Res Function(_$DispositifListImpl) then) =
      __$$DispositifListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Dispositif> values});
}

/// @nodoc
class __$$DispositifListImplCopyWithImpl<$Res>
    extends _$DispositifListCopyWithImpl<$Res, _$DispositifListImpl>
    implements _$$DispositifListImplCopyWith<$Res> {
  __$$DispositifListImplCopyWithImpl(
      _$DispositifListImpl _value, $Res Function(_$DispositifListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$DispositifListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Dispositif>,
    ));
  }
}

/// @nodoc

class _$DispositifListImpl extends _DispositifList {
  const _$DispositifListImpl({required final List<Dispositif> values})
      : _values = values,
        super._();

  final List<Dispositif> _values;
  @override
  List<Dispositif> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'DispositifList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DispositifListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DispositifListImplCopyWith<_$DispositifListImpl> get copyWith =>
      __$$DispositifListImplCopyWithImpl<_$DispositifListImpl>(
          this, _$identity);
}

abstract class _DispositifList extends DispositifList {
  const factory _DispositifList({required final List<Dispositif> values}) =
      _$DispositifListImpl;
  const _DispositifList._() : super._();

  @override
  List<Dispositif> get values;
  @override
  @JsonKey(ignore: true)
  _$$DispositifListImplCopyWith<_$DispositifListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
