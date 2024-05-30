import 'package:dendro3/data/datasource/interface/api/authentication_api.dart';
import 'package:dendro3/data/mapper/user_mapper.dart';
import 'package:dendro3/domain/model/user.dart';
import 'package:dendro3/domain/repository/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi api;

  const AuthenticationRepositoryImpl(this.api);

  @override
  Future<User> login(final String identifiant, final String password) async {
    try {
      final userEntity = await api.login(identifiant, password);
      return UserMapper.transformToModel(userEntity);
    } catch (e) {
      // Handle or log the error accordingly
      print("Error in AuthenticationRepositoryImpl login: $e");
      rethrow;
    }
  }
}
