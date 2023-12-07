import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@Freezed()
class User with _$User {
  const factory User(
      {required int id,
      required String nom,
      required String prenom,
      required String identifiant,
      required int id_organisme}) = _User;

  const User._();
}
