// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corCyclePlacette_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CorCyclePlacetteList {
  List<CorCyclePlacette> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CorCyclePlacetteListCopyWith<CorCyclePlacetteList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorCyclePlacetteListCopyWith<$Res> {
  factory $CorCyclePlacetteListCopyWith(CorCyclePlacetteList value,
          $Res Function(CorCyclePlacetteList) then) =
      _$CorCyclePlacetteListCopyWithImpl<$Res, CorCyclePlacetteList>;
  @useResult
  $Res call({List<CorCyclePlacette> values});
}

/// @nodoc
class _$CorCyclePlacetteListCopyWithImpl<$Res,
        $Val extends CorCyclePlacetteList>
    implements $CorCyclePlacetteListCopyWith<$Res> {
  _$CorCyclePlacetteListCopyWithImpl(this._value, this._then);

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
              as List<CorCyclePlacette>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorCyclePlacetteListImplCopyWith<$Res>
    implements $CorCyclePlacetteListCopyWith<$Res> {
  factory _$$CorCyclePlacetteListImplCopyWith(_$CorCyclePlacetteListImpl value,
          $Res Function(_$CorCyclePlacetteListImpl) then) =
      __$$CorCyclePlacetteListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CorCyclePlacette> values});
}

/// @nodoc
class __$$CorCyclePlacetteListImplCopyWithImpl<$Res>
    extends _$CorCyclePlacetteListCopyWithImpl<$Res, _$CorCyclePlacetteListImpl>
    implements _$$CorCyclePlacetteListImplCopyWith<$Res> {
  __$$CorCyclePlacetteListImplCopyWithImpl(_$CorCyclePlacetteListImpl _value,
      $Res Function(_$CorCyclePlacetteListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$CorCyclePlacetteListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<CorCyclePlacette>,
    ));
  }
}

/// @nodoc

class _$CorCyclePlacetteListImpl extends _CorCyclePlacetteList {
  const _$CorCyclePlacetteListImpl(
      {required final List<CorCyclePlacette> values})
      : _values = values,
        super._();

  final List<CorCyclePlacette> _values;
  @override
  List<CorCyclePlacette> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'CorCyclePlacetteList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorCyclePlacetteListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorCyclePlacetteListImplCopyWith<_$CorCyclePlacetteListImpl>
      get copyWith =>
          __$$CorCyclePlacetteListImplCopyWithImpl<_$CorCyclePlacetteListImpl>(
              this, _$identity);
}

abstract class _CorCyclePlacetteList extends CorCyclePlacetteList {
  const factory _CorCyclePlacetteList(
          {required final List<CorCyclePlacette> values}) =
      _$CorCyclePlacetteListImpl;
  const _CorCyclePlacetteList._() : super._();

  @override
  List<CorCyclePlacette> get values;
  @override
  @JsonKey(ignore: true)
  _$$CorCyclePlacetteListImplCopyWith<_$CorCyclePlacetteListImpl>
      get copyWith => throw _privateConstructorUsedError;
}
