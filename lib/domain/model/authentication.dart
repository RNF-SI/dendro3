import 'package:flutter/material.dart';
import 'package:dendro3/domain/model/user.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication.freezed.dart';

@Freezed()
class Authentication with _$Authentication {
  const factory Authentication() = _Authentication;

  const Authentication._();
}
