// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'dispositif.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Dispositif {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get idOrganisme => throw _privateConstructorUsedError;
  bool get alluvial => throw _privateConstructorUsedError;
  PlacetteList? get placettes => throw _privateConstructorUsedError;
  CycleList? get cycles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DispositifCopyWith<Dispositif> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DispositifCopyWith<$Res> {
  factory $DispositifCopyWith(
          Dispositif value, $Res Function(Dispositif) then) =
      _$DispositifCopyWithImpl<$Res, Dispositif>;
  @useResult
  $Res call(
      {int id,
      String name,
      int idOrganisme,
      bool alluvial,
      PlacetteList? placettes,
      CycleList? cycles});

  $PlacetteListCopyWith<$Res>? get placettes;
  $CycleListCopyWith<$Res>? get cycles;
}

/// @nodoc
class _$DispositifCopyWithImpl<$Res, $Val extends Dispositif>
    implements $DispositifCopyWith<$Res> {
  _$DispositifCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? idOrganisme = null,
    Object? alluvial = null,
    Object? placettes = freezed,
    Object? cycles = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      idOrganisme: null == idOrganisme
          ? _value.idOrganisme
          : idOrganisme // ignore: cast_nullable_to_non_nullable
              as int,
      alluvial: null == alluvial
          ? _value.alluvial
          : alluvial // ignore: cast_nullable_to_non_nullable
              as bool,
      placettes: freezed == placettes
          ? _value.placettes
          : placettes // ignore: cast_nullable_to_non_nullable
              as PlacetteList?,
      cycles: freezed == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as CycleList?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlacetteListCopyWith<$Res>? get placettes {
    if (_value.placettes == null) {
      return null;
    }

    return $PlacetteListCopyWith<$Res>(_value.placettes!, (value) {
      return _then(_value.copyWith(placettes: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CycleListCopyWith<$Res>? get cycles {
    if (_value.cycles == null) {
      return null;
    }

    return $CycleListCopyWith<$Res>(_value.cycles!, (value) {
      return _then(_value.copyWith(cycles: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DispositifCopyWith<$Res>
    implements $DispositifCopyWith<$Res> {
  factory _$$_DispositifCopyWith(
          _$_Dispositif value, $Res Function(_$_Dispositif) then) =
      __$$_DispositifCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      int idOrganisme,
      bool alluvial,
      PlacetteList? placettes,
      CycleList? cycles});

  @override
  $PlacetteListCopyWith<$Res>? get placettes;
  @override
  $CycleListCopyWith<$Res>? get cycles;
}

/// @nodoc
class __$$_DispositifCopyWithImpl<$Res>
    extends _$DispositifCopyWithImpl<$Res, _$_Dispositif>
    implements _$$_DispositifCopyWith<$Res> {
  __$$_DispositifCopyWithImpl(
      _$_Dispositif _value, $Res Function(_$_Dispositif) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? idOrganisme = null,
    Object? alluvial = null,
    Object? placettes = freezed,
    Object? cycles = freezed,
  }) {
    return _then(_$_Dispositif(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      idOrganisme: null == idOrganisme
          ? _value.idOrganisme
          : idOrganisme // ignore: cast_nullable_to_non_nullable
              as int,
      alluvial: null == alluvial
          ? _value.alluvial
          : alluvial // ignore: cast_nullable_to_non_nullable
              as bool,
      placettes: freezed == placettes
          ? _value.placettes
          : placettes // ignore: cast_nullable_to_non_nullable
              as PlacetteList?,
      cycles: freezed == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as CycleList?,
    ));
  }
}

/// @nodoc

class _$_Dispositif extends _Dispositif {
  const _$_Dispositif(
      {required this.id,
      required this.name,
      required this.idOrganisme,
      required this.alluvial,
      this.placettes,
      this.cycles})
      : super._();

  @override
  final int id;
  @override
  final String name;
  @override
  final int idOrganisme;
  @override
  final bool alluvial;
  @override
  final PlacetteList? placettes;
  @override
  final CycleList? cycles;

  @override
  String toString() {
    return 'Dispositif(id: $id, name: $name, idOrganisme: $idOrganisme, alluvial: $alluvial, placettes: $placettes, cycles: $cycles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Dispositif &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.idOrganisme, idOrganisme) ||
                other.idOrganisme == idOrganisme) &&
            (identical(other.alluvial, alluvial) ||
                other.alluvial == alluvial) &&
            (identical(other.placettes, placettes) ||
                other.placettes == placettes) &&
            (identical(other.cycles, cycles) || other.cycles == cycles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, idOrganisme, alluvial, placettes, cycles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DispositifCopyWith<_$_Dispositif> get copyWith =>
      __$$_DispositifCopyWithImpl<_$_Dispositif>(this, _$identity);
}

abstract class _Dispositif extends Dispositif {
  const factory _Dispositif(
      {required final int id,
      required final String name,
      required final int idOrganisme,
      required final bool alluvial,
      final PlacetteList? placettes,
      final CycleList? cycles}) = _$_Dispositif;
  const _Dispositif._() : super._();

  @override
  int get id;
  @override
  String get name;
  @override
  int get idOrganisme;
  @override
  bool get alluvial;
  @override
  PlacetteList? get placettes;
  @override
  CycleList? get cycles;
  @override
  @JsonKey(ignore: true)
  _$$_DispositifCopyWith<_$_Dispositif> get copyWith =>
      throw _privateConstructorUsedError;
}
