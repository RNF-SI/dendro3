import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/placettes_database_impl.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/datasource/interface/database/placettes_database.dart';
import 'package:dendro3/data/repository/dispositifs_repository_impl.dart';
import 'package:dendro3/data/repository/global_database_repository_impl.dart';
import 'package:dendro3/data/repository/placettes_repository_impl.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/data/repository/authentication_repository_impl.dart';
import 'package:dendro3/domain/repository/authentication_repository.dart';
import 'package:dendro3/domain/repository/global_database_repository.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'datasource/interface/database/dispositifs_database.dart';
import 'datasource/implementation/database/dispositifs_database_impl.dart';
import 'datasource/interface/api/dispositifs_api.dart';
import 'datasource/implementation/api/dispositifs_api_impl.dart';
import 'datasource/interface/api/authentication_api.dart';
import 'datasource/implementation/api/authentication_api_impl.dart';

final globalDatabaseProvider =
    Provider<GlobalDatabase>((_) => GlobalDatabaseImpl());
final globalDatabaseRepositoryProvider = Provider<GlobalDatabaseRepository>(
    (ref) => GlobalDatabaseRepositoryImpl(ref.watch(globalDatabaseProvider)));

final dispositifsDatabaseProvider =
    Provider<DispositifsDatabase>((_) => DispositifsDatabaseImpl());
final dispositifsApiProvider =
    Provider<DispositifsApi>((_) => DispositifsApiImpl());
final dispositifsRepositoryProvider = Provider<DispositifsRepository>((ref) =>
    DispositifsRepositoryImpl(ref.watch(dispositifsDatabaseProvider),
        ref.watch(dispositifsApiProvider)));

final authenticationApiProvider =
    Provider<AuthenticationApi>((_) => AuthenticationApiImpl());
final authenticationRepositoryProvider = Provider<AuthenticationRepository>(
    (ref) =>
        AuthenticationRepositoryImpl(ref.watch(authenticationApiProvider)));

final placettesProvider =
    Provider<PlacettesDatabase>((_) => PlacettesDatabaseImpl());
final placettesRepositoryProvider = Provider<PlacettesRepository>(
    (ref) => PlacettesRepositoryImpl(ref.watch(placettesProvider)));
