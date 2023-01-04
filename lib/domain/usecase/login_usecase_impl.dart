import 'package:dendro3/domain/model/user.dart';
import 'package:dendro3/domain/repository/authentication_repository.dart';
import 'package:dendro3/domain/usecase/login_usecase.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final AuthenticationRepository _repository;

  const LoginUseCaseImpl(this._repository);

  @override
  Future<User> execute(String email, String password) =>
      _repository.login(email, password);
}
