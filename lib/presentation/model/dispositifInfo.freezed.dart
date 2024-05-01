// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dispositifInfo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DispositifInfo {
  Dispositif get dispositif => throw _privateConstructorUsedError;
  DownloadStatus get downloadStatus => throw _privateConstructorUsedError;
  double get downloadProgress => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DispositifInfoCopyWith<DispositifInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DispositifInfoCopyWith<$Res> {
  factory $DispositifInfoCopyWith(
          DispositifInfo value, $Res Function(DispositifInfo) then) =
      _$DispositifInfoCopyWithImpl<$Res, DispositifInfo>;
  @useResult
  $Res call(
      {Dispositif dispositif,
      DownloadStatus downloadStatus,
      double downloadProgress});

  $DispositifCopyWith<$Res> get dispositif;
}

/// @nodoc
class _$DispositifInfoCopyWithImpl<$Res, $Val extends DispositifInfo>
    implements $DispositifInfoCopyWith<$Res> {
  _$DispositifInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dispositif = null,
    Object? downloadStatus = null,
    Object? downloadProgress = null,
  }) {
    return _then(_value.copyWith(
      dispositif: null == dispositif
          ? _value.dispositif
          : dispositif // ignore: cast_nullable_to_non_nullable
              as Dispositif,
      downloadStatus: null == downloadStatus
          ? _value.downloadStatus
          : downloadStatus // ignore: cast_nullable_to_non_nullable
              as DownloadStatus,
      downloadProgress: null == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DispositifCopyWith<$Res> get dispositif {
    return $DispositifCopyWith<$Res>(_value.dispositif, (value) {
      return _then(_value.copyWith(dispositif: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DispositifInfoImplCopyWith<$Res>
    implements $DispositifInfoCopyWith<$Res> {
  factory _$$DispositifInfoImplCopyWith(_$DispositifInfoImpl value,
          $Res Function(_$DispositifInfoImpl) then) =
      __$$DispositifInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Dispositif dispositif,
      DownloadStatus downloadStatus,
      double downloadProgress});

  @override
  $DispositifCopyWith<$Res> get dispositif;
}

/// @nodoc
class __$$DispositifInfoImplCopyWithImpl<$Res>
    extends _$DispositifInfoCopyWithImpl<$Res, _$DispositifInfoImpl>
    implements _$$DispositifInfoImplCopyWith<$Res> {
  __$$DispositifInfoImplCopyWithImpl(
      _$DispositifInfoImpl _value, $Res Function(_$DispositifInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dispositif = null,
    Object? downloadStatus = null,
    Object? downloadProgress = null,
  }) {
    return _then(_$DispositifInfoImpl(
      dispositif: null == dispositif
          ? _value.dispositif
          : dispositif // ignore: cast_nullable_to_non_nullable
              as Dispositif,
      downloadStatus: null == downloadStatus
          ? _value.downloadStatus
          : downloadStatus // ignore: cast_nullable_to_non_nullable
              as DownloadStatus,
      downloadProgress: null == downloadProgress
          ? _value.downloadProgress
          : downloadProgress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DispositifInfoImpl extends _DispositifInfo {
  const _$DispositifInfoImpl(
      {required this.dispositif,
      required this.downloadStatus,
      this.downloadProgress = 0.0})
      : super._();

  @override
  final Dispositif dispositif;
  @override
  final DownloadStatus downloadStatus;
  @override
  @JsonKey()
  final double downloadProgress;

  @override
  String toString() {
    return 'DispositifInfo(dispositif: $dispositif, downloadStatus: $downloadStatus, downloadProgress: $downloadProgress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DispositifInfoImpl &&
            (identical(other.dispositif, dispositif) ||
                other.dispositif == dispositif) &&
            (identical(other.downloadStatus, downloadStatus) ||
                other.downloadStatus == downloadStatus) &&
            (identical(other.downloadProgress, downloadProgress) ||
                other.downloadProgress == downloadProgress));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dispositif, downloadStatus, downloadProgress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DispositifInfoImplCopyWith<_$DispositifInfoImpl> get copyWith =>
      __$$DispositifInfoImplCopyWithImpl<_$DispositifInfoImpl>(
          this, _$identity);
}

abstract class _DispositifInfo extends DispositifInfo {
  const factory _DispositifInfo(
      {required final Dispositif dispositif,
      required final DownloadStatus downloadStatus,
      final double downloadProgress}) = _$DispositifInfoImpl;
  const _DispositifInfo._() : super._();

  @override
  Dispositif get dispositif;
  @override
  DownloadStatus get downloadStatus;
  @override
  double get downloadProgress;
  @override
  @JsonKey(ignore: true)
  _$$DispositifInfoImplCopyWith<_$DispositifInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
