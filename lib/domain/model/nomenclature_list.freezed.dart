// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nomenclature_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NomenclatureList {
  List<Nomenclature> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NomenclatureListCopyWith<NomenclatureList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NomenclatureListCopyWith<$Res> {
  factory $NomenclatureListCopyWith(
          NomenclatureList value, $Res Function(NomenclatureList) then) =
      _$NomenclatureListCopyWithImpl<$Res, NomenclatureList>;
  @useResult
  $Res call({List<Nomenclature> values});
}

/// @nodoc
class _$NomenclatureListCopyWithImpl<$Res, $Val extends NomenclatureList>
    implements $NomenclatureListCopyWith<$Res> {
  _$NomenclatureListCopyWithImpl(this._value, this._then);

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
              as List<Nomenclature>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NomenclatureListImplCopyWith<$Res>
    implements $NomenclatureListCopyWith<$Res> {
  factory _$$NomenclatureListImplCopyWith(_$NomenclatureListImpl value,
          $Res Function(_$NomenclatureListImpl) then) =
      __$$NomenclatureListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Nomenclature> values});
}

/// @nodoc
class __$$NomenclatureListImplCopyWithImpl<$Res>
    extends _$NomenclatureListCopyWithImpl<$Res, _$NomenclatureListImpl>
    implements _$$NomenclatureListImplCopyWith<$Res> {
  __$$NomenclatureListImplCopyWithImpl(_$NomenclatureListImpl _value,
      $Res Function(_$NomenclatureListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$NomenclatureListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<Nomenclature>,
    ));
  }
}

/// @nodoc

class _$NomenclatureListImpl extends _NomenclatureList {
  const _$NomenclatureListImpl({required final List<Nomenclature> values})
      : _values = values,
        super._();

  final List<Nomenclature> _values;
  @override
  List<Nomenclature> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'NomenclatureList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NomenclatureListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NomenclatureListImplCopyWith<_$NomenclatureListImpl> get copyWith =>
      __$$NomenclatureListImplCopyWithImpl<_$NomenclatureListImpl>(
          this, _$identity);
}

abstract class _NomenclatureList extends NomenclatureList {
  const factory _NomenclatureList({required final List<Nomenclature> values}) =
      _$NomenclatureListImpl;
  const _NomenclatureList._() : super._();

  @override
  List<Nomenclature> get values;
  @override
  @JsonKey(ignore: true)
  _$$NomenclatureListImplCopyWith<_$NomenclatureListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
