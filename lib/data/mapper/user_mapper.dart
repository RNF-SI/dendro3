import 'package:dendro3/data/entity/user_entity.dart';
import 'package:dendro3/domain/model/user.dart';

class UserMapper {
  static User transformToModel(final UserEntity entity) {
    return User(
        id: entity['id_role'],
        nom: entity['nom_role'],
        prenom: entity['prenom_role'],
        identifiant: entity['identifiant'],
        id_organisme: entity['id_organisme']);
  }
}
