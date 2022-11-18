import 'package:dendro3/data/repository/dispositifs_repository_impl.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'datasource/interface/dispositifs_database.dart';
import 'datasource/implementation/database/dispositifs_database_impl.dart';

final dispositifsDatabaseProvider =
    Provider<DispositifsDatabase>((_) => DispositifsDatabaseImpl());
final dispositifsRepositoryProvider = Provider<DispositifsRepository>(
    (ref) => DispositifsRepositoryImpl(ref.watch(dispositifsDatabaseProvider)));
