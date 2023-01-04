import 'package:dendro3/domain/model/user.dart';

abstract class AuthenticationRepository {
  Future<User> login(final String identifiant, final String password);
}
