// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispositifInfo_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DispositifInfoList {
  List<DispositifInfo> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DispositifInfoListCopyWith<DispositifInfoList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DispositifInfoListCopyWith<$Res> {
  factory $DispositifInfoListCopyWith(
          DispositifInfoList value, $Res Function(DispositifInfoList) then) =
      _$DispositifInfoListCopyWithImpl<$Res, DispositifInfoList>;
  @useResult
  $Res call({List<DispositifInfo> values});
}

/// @nodoc
class _$DispositifInfoListCopyWithImpl<$Res, $Val extends DispositifInfoList>
    implements $DispositifInfoListCopyWith<$Res> {
  _$DispositifInfoListCopyWithImpl(this._value, this._then);

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
              as List<DispositifInfo>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DispositifInfoListImplCopyWith<$Res>
    implements $DispositifInfoListCopyWith<$Res> {
  factory _$$DispositifInfoListImplCopyWith(_$DispositifInfoListImpl value,
          $Res Function(_$DispositifInfoListImpl) then) =
      __$$DispositifInfoListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<DispositifInfo> values});
}

/// @nodoc
class __$$DispositifInfoListImplCopyWithImpl<$Res>
    extends _$DispositifInfoListCopyWithImpl<$Res, _$DispositifInfoListImpl>
    implements _$$DispositifInfoListImplCopyWith<$Res> {
  __$$DispositifInfoListImplCopyWithImpl(_$DispositifInfoListImpl _value,
      $Res Function(_$DispositifInfoListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
  }) {
    return _then(_$DispositifInfoListImpl(
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<DispositifInfo>,
    ));
  }
}

/// @nodoc

class _$DispositifInfoListImpl extends _DispositifInfoList {
  const _$DispositifInfoListImpl({required final List<DispositifInfo> values})
      : _values = values,
        super._();

  final List<DispositifInfo> _values;
  @override
  List<DispositifInfo> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'DispositifInfoList(values: $values)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DispositifInfoListImpl &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DispositifInfoListImplCopyWith<_$DispositifInfoListImpl> get copyWith =>
      __$$DispositifInfoListImplCopyWithImpl<_$DispositifInfoListImpl>(
          this, _$identity);
}

abstract class _DispositifInfoList extends DispositifInfoList {
  const factory _DispositifInfoList(
      {required final List<DispositifInfo> values}) = _$DispositifInfoListImpl;
  const _DispositifInfoList._() : super._();

  @override
  List<DispositifInfo> get values;
  @override
  @JsonKey(ignore: true)
  _$$DispositifInfoListImplCopyWith<_$DispositifInfoListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
