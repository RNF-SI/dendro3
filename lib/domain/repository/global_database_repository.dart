import 'package:dendro3/domain/model/user.dart';

abstract class GlobalDatabaseRepository {
  Future<void> initDatabase();
}
