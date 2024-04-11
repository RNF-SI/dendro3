// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nomenclatureType_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NomenclatureTypeList {
  List<NomenclatureType> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NomenclatureTypeListCopyWith<NomenclatureTypeList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NomenclatureTypeListCopyWith<$Res> {
  factory $NomenclatureTypeListCopyWith(NomenclatureTypeList value,
          $Res Function(NomenclatureTypeList) then) =
      _$NomenclatureTypeListCopyWithImpl<$Res, NomenclatureTypeList>;
  @useResult
  $Res call({List<NomenclatureType> values});
}

/// @nodoc
class _$NomenclatureTypeListCopyWithImpl<$Res,
        $Val extends NomenclatureTypeList>
    implements $NomenclatureTypeListCopyWith<$Res> {
  _$NomenclatureTypeListCopyWithImpl(this._value, this._then);

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
              as List<NomenclatureType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NomenclatureTypeListImplCopyWith<$Res>
    implements $NomenclatureTypeListCopyWith<$Res> {
  factory _$$NomenclatureTypeListImplCopyWith(_$NomenclatureTypeListImpl value,
          $Res Function(_$NomenclatureTypeListImpl) then) =
      __$$NomenclatureTypeListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<NomenclatureType> values});
}

/// @nodoc
class __$$NomenclatureTypeListImplCopyWithImpl<$Res>
    extends _$NomenclatureTypeListCopyWithImpl<$Res, _$NomenclatureTypeListImpl>
    implements _$$NomenclatureTypeListImplCopyWith<$Res> {
  __$$NomenclatureTypeListImplCopyWithImpl(_$NomenclatureTypeListImpl _value,
      $Res Function(_$NomenclatureTypeListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$NomenclatureTypeListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<NomenclatureType>,
    ));
  }
}

/// @nodoc

class _$NomenclatureTypeListImpl extends _NomenclatureTypeList {
  const _$NomenclatureTypeListImpl(
      {required final List<NomenclatureType> values})
      : _values = values,
        super._();

  final List<NomenclatureType> _values;
  @override
  List<NomenclatureType> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'NomenclatureTypeList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NomenclatureTypeListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NomenclatureTypeListImplCopyWith<_$NomenclatureTypeListImpl>
      get copyWith =>
          __$$NomenclatureTypeListImplCopyWithImpl<_$NomenclatureTypeListImpl>(
              this, _$identity);
}

abstract class _NomenclatureTypeList extends NomenclatureTypeList {
  const factory _NomenclatureTypeList(
          {required final List<NomenclatureType> values}) =
      _$NomenclatureTypeListImpl;
  const _NomenclatureTypeList._() : super._();

  @override
  List<NomenclatureType> get values;
  @override
  @JsonKey(ignore: true)
  _$$NomenclatureTypeListImplCopyWith<_$NomenclatureTypeListImpl>
      get copyWith => throw _privateConstructorUsedError;
}
