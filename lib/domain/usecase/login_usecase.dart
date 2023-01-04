import 'package:dendro3/domain/model/user.dart';

abstract class LoginUseCase {
  Future<User> execute(
    final String email,
    final String password,
  );
}
