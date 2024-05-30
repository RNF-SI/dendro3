import 'package:dendro3/data/entity/user_entity.dart';

abstract class AuthenticationApi {
  Future<UserEntity> login(String email, String password);
}
