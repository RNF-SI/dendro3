// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'essence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Essence {
  String get codeEssence => throw _privateConstructorUsedError;
  int? get cdNom => throw _privateConstructorUsedError;
  String get nom => throw _privateConstructorUsedError;
  String? get nomLatin => throw _privateConstructorUsedError;
  String? get essReg => throw _privateConstructorUsedError;
  String? get couleur => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EssenceCopyWith<Essence> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EssenceCopyWith<$Res> {
  factory $EssenceCopyWith(Essence value, $Res Function(Essence) then) =
      _$EssenceCopyWithImpl<$Res, Essence>;
  @useResult
  $Res call(
      {String codeEssence,
      int? cdNom,
      String nom,
      String? nomLatin,
      String? essReg,
      String? couleur});
}

/// @nodoc
class _$EssenceCopyWithImpl<$Res, $Val extends Essence>
    implements $EssenceCopyWith<$Res> {
  _$EssenceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeEssence = null,
    Object? cdNom = freezed,
    Object? nom = null,
    Object? nomLatin = freezed,
    Object? essReg = freezed,
    Object? couleur = freezed,
  }) {
    return _then(_value.copyWith(
      codeEssence: null == codeEssence
          ? _value.codeEssence
          : codeEssence // ignore: cast_nullable_to_non_nullable
              as String,
      cdNom: freezed == cdNom
          ? _value.cdNom
          : cdNom // ignore: cast_nullable_to_non_nullable
              as int?,
      nom: null == nom
          ? _value.nom
          : nom // ignore: cast_nullable_to_non_nullable
              as String,
      nomLatin: freezed == nomLatin
          ? _value.nomLatin
          : nomLatin // ignore: cast_nullable_to_non_nullable
              as String?,
      essReg: freezed == essReg
          ? _value.essReg
          : essReg // ignore: cast_nullable_to_non_nullable
              as String?,
      couleur: freezed == couleur
          ? _value.couleur
          : couleur // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EssenceImplCopyWith<$Res> implements $EssenceCopyWith<$Res> {
  factory _$$EssenceImplCopyWith(
          _$EssenceImpl value, $Res Function(_$EssenceImpl) then) =
      __$$EssenceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String codeEssence,
      int? cdNom,
      String nom,
      String? nomLatin,
      String? essReg,
      String? couleur});
}

/// @nodoc
class __$$EssenceImplCopyWithImpl<$Res>
    extends _$EssenceCopyWithImpl<$Res, _$EssenceImpl>
    implements _$$EssenceImplCopyWith<$Res> {
  __$$EssenceImplCopyWithImpl(
      _$EssenceImpl _value, $Res Function(_$EssenceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codeEssence = null,
    Object? cdNom = freezed,
    Object? nom = null,
    Object? nomLatin = freezed,
    Object? essReg = freezed,
    Object? couleur = freezed,
  }) {
    return _then(_$EssenceImpl(
      codeEssence: null == codeEssence
          ? _value.codeEssence
          : codeEssence // ignore: cast_nullable_to_non_nullable
              as String,
      cdNom: freezed == cdNom
          ? _value.cdNom
          : cdNom // ignore: cast_nullable_to_non_nullable
              as int?,
      nom: null == nom
          ? _value.nom
          : nom // ignore: cast_nullable_to_non_nullable
              as String,
      nomLatin: freezed == nomLatin
          ? _value.nomLatin
          : nomLatin // ignore: cast_nullable_to_non_nullable
              as String?,
      essReg: freezed == essReg
          ? _value.essReg
          : essReg // ignore: cast_nullable_to_non_nullable
              as String?,
      couleur: freezed == couleur
          ? _value.couleur
          : couleur // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$EssenceImpl extends _Essence {
  const _$EssenceImpl(
      {required this.codeEssence,
      this.cdNom,
      required this.nom,
      this.nomLatin,
      this.essReg,
      this.couleur})
      : super._();

  @override
  final String codeEssence;
  @override
  final int? cdNom;
  @override
  final String nom;
  @override
  final String? nomLatin;
  @override
  final String? essReg;
  @override
  final String? couleur;

  @override
  String toString() {
    return 'Essence(codeEssence: $codeEssence, cdNom: $cdNom, nom: $nom, nomLatin: $nomLatin, essReg: $essReg, couleur: $couleur)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EssenceImpl &&
            (identical(other.codeEssence, codeEssence) ||
                other.codeEssence == codeEssence) &&
            (identical(other.cdNom, cdNom) || other.cdNom == cdNom) &&
            (identical(other.nom, nom) || other.nom == nom) &&
            (identical(other.nomLatin, nomLatin) ||
                other.nomLatin == nomLatin) &&
            (identical(other.essReg, essReg) || other.essReg == essReg) &&
            (identical(other.couleur, couleur) || other.couleur == couleur));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, codeEssence, cdNom, nom, nomLatin, essReg, couleur);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EssenceImplCopyWith<_$EssenceImpl> get copyWith =>
      __$$EssenceImplCopyWithImpl<_$EssenceImpl>(this, _$identity);
}

abstract class _Essence extends Essence {
  const factory _Essence(
      {required final String codeEssence,
      final int? cdNom,
      required final String nom,
      final String? nomLatin,
      final String? essReg,
      final String? couleur}) = _$EssenceImpl;
  const _Essence._() : super._();

  @override
  String get codeEssence;
  @override
  int? get cdNom;
  @override
  String get nom;
  @override
  String? get nomLatin;
  @override
  String? get essReg;
  @override
  String? get couleur;
  @override
  @JsonKey(ignore: true)
  _$$EssenceImplCopyWith<_$EssenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
