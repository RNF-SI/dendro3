// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'repere.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Repere {
  String get idRepere => throw _privateConstructorUsedError;
  int get idPlacette => throw _privateConstructorUsedError;
  double? get azimut => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  double? get diametre => throw _privateConstructorUsedError;
  String? get repere => throw _privateConstructorUsedError;
  String? get observation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RepereCopyWith<Repere> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepereCopyWith<$Res> {
  factory $RepereCopyWith(Repere value, $Res Function(Repere) then) =
      _$RepereCopyWithImpl<$Res, Repere>;
  @useResult
  $Res call(
      {String idRepere,
      int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation});
}

/// @nodoc
class _$RepereCopyWithImpl<$Res, $Val extends Repere>
    implements $RepereCopyWith<$Res> {
  _$RepereCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idRepere = null,
    Object? idPlacette = null,
    Object? azimut = freezed,
    Object? distance = freezed,
    Object? diametre = freezed,
    Object? repere = freezed,
    Object? observation = freezed,
  }) {
    return _then(_value.copyWith(
      idRepere: null == idRepere
          ? _value.idRepere
          : idRepere // ignore: cast_nullable_to_non_nullable
              as String,
      idPlacette: null == idPlacette
          ? _value.idPlacette
          : idPlacette // ignore: cast_nullable_to_non_nullable
              as int,
      azimut: freezed == azimut
          ? _value.azimut
          : azimut // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      diametre: freezed == diametre
          ? _value.diametre
          : diametre // ignore: cast_nullable_to_non_nullable
              as double?,
      repere: freezed == repere
          ? _value.repere
          : repere // ignore: cast_nullable_to_non_nullable
              as String?,
      observation: freezed == observation
          ? _value.observation
          : observation // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepereImplCopyWith<$Res> implements $RepereCopyWith<$Res> {
  factory _$$RepereImplCopyWith(
          _$RepereImpl value, $Res Function(_$RepereImpl) then) =
      __$$RepereImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String idRepere,
      int idPlacette,
      double? azimut,
      double? distance,
      double? diametre,
      String? repere,
      String? observation});
}

/// @nodoc
class __$$RepereImplCopyWithImpl<$Res>
    extends _$RepereCopyWithImpl<$Res, _$RepereImpl>
    implements _$$RepereImplCopyWith<$Res> {
  __$$RepereImplCopyWithImpl(
      _$RepereImpl _value, $Res Function(_$RepereImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idRepere = null,
    Object? idPlacette = null,
    Object? azimut = freezed,
    Object? distance = freezed,
    Object? diametre = freezed,
    Object? repere = freezed,
    Object? observation = freezed,
  }) {
    return _then(_$RepereImpl(
      idRepere: null == idRepere
          ? _value.idRepere
          : idRepere // ignore: cast_nullable_to_non_nullable
              as String,
      idPlacette: null == idPlacette
          ? _value.idPlacette
          : idPlacette // ignore: cast_nullable_to_non_nullable
              as int,
      azimut: freezed == azimut
          ? _value.azimut
          : azimut // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      diametre: freezed == diametre
          ? _value.diametre
          : diametre // ignore: cast_nullable_to_non_nullable
              as double?,
      repere: freezed == repere
          ? _value.repere
          : repere // ignore: cast_nullable_to_non_nullable
              as String?,
      observation: freezed == observation
          ? _value.observation
          : observation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RepereImpl extends _Repere {
  const _$RepereImpl(
      {required this.idRepere,
      required this.idPlacette,
      this.azimut,
      this.distance,
      this.diametre,
      this.repere,
      this.observation})
      : super._();

  @override
  final String idRepere;
  @override
  final int idPlacette;
  @override
  final double? azimut;
  @override
  final double? distance;
  @override
  final double? diametre;
  @override
  final String? repere;
  @override
  final String? observation;

  @override
  String toString() {
    return 'Repere(idRepere: $idRepere, idPlacette: $idPlacette, azimut: $azimut, distance: $distance, diametre: $diametre, repere: $repere, observation: $observation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepereImpl &&
            (identical(other.idRepere, idRepere) ||
                other.idRepere == idRepere) &&
            (identical(other.idPlacette, idPlacette) ||
                other.idPlacette == idPlacette) &&
            (identical(other.azimut, azimut) || other.azimut == azimut) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.diametre, diametre) ||
                other.diametre == diametre) &&
            (identical(other.repere, repere) || other.repere == repere) &&
            (identical(other.observation, observation) ||
                other.observation == observation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, idRepere, idPlacette, azimut,
      distance, diametre, repere, observation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepereImplCopyWith<_$RepereImpl> get copyWith =>
      __$$RepereImplCopyWithImpl<_$RepereImpl>(this, _$identity);
}

abstract class _Repere extends Repere {
  const factory _Repere(
      {required final String idRepere,
      required final int idPlacette,
      final double? azimut,
      final double? distance,
      final double? diametre,
      final String? repere,
      final String? observation}) = _$RepereImpl;
  const _Repere._() : super._();

  @override
  String get idRepere;
  @override
  int get idPlacette;
  @override
  double? get azimut;
  @override
  double? get distance;
  @override
  double? get diametre;
  @override
  String? get repere;
  @override
  String? get observation;
  @override
  @JsonKey(ignore: true)
  _$$RepereImplCopyWith<_$RepereImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
