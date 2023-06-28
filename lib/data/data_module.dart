import 'package:dendro3/data/datasource/implementation/api/cycles_api_impl.dart';
import 'package:dendro3/data/datasource/implementation/api/global_api_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/arbres_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/arbres_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/corCyclesPlacettes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/cycles_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/essences_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/placettes_database_impl.dart';
import 'package:dendro3/data/datasource/interface/api/cycles_api.dart';
import 'package:dendro3/data/datasource/interface/api/global_api.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/datasource/interface/database/corCyclesPlacettes_database.dart';
import 'package:dendro3/data/datasource/interface/database/cycles_database.dart';
import 'package:dendro3/data/datasource/interface/database/essences_database.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/datasource/interface/database/placettes_database.dart';
import 'package:dendro3/data/repository/arbre_repository_impl.dart';
import 'package:dendro3/data/repository/arbres_mesures_repository_impl.dart';
import 'package:dendro3/data/repository/cor_cycles_placettes_repository_impl.dart';
import 'package:dendro3/data/repository/cycles_repository_impl.dart';
import 'package:dendro3/data/repository/dispositifs_repository_impl.dart';
import 'package:dendro3/data/repository/essences_repository_impl.dart';
import 'package:dendro3/data/repository/global_database_repository_impl.dart';
import 'package:dendro3/data/repository/placettes_repository_impl.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/cycles_repository.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/data/repository/authentication_repository_impl.dart';
import 'package:dendro3/domain/repository/authentication_repository.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/repository/global_database_repository.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'datasource/interface/database/dispositifs_database.dart';
import 'datasource/implementation/database/dispositifs_database_impl.dart';
import 'datasource/interface/api/dispositifs_api.dart';
import 'datasource/implementation/api/dispositifs_api_impl.dart';
import 'datasource/interface/api/authentication_api.dart';
import 'datasource/implementation/api/authentication_api_impl.dart';

final globalApiProvider = Provider<GlobalApi>((_) => GlobalApiImpl());
final globalDatabaseProvider =
    Provider<GlobalDatabase>((_) => GlobalDatabaseImpl());
final globalDatabaseRepositoryProvider = Provider<GlobalDatabaseRepository>(
    (ref) => GlobalDatabaseRepositoryImpl(
        ref.watch(globalDatabaseProvider), ref.watch(globalApiProvider)));

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

final cyclesDatabaseProvider =
    Provider<CyclesDatabase>((_) => CyclesDatabaseImpl());
final cyclesApiProvider = Provider<CyclesApi>((_) => CyclesApiImpl());
final cyclesRepositoryProvider = Provider<CyclesRepository>((ref) =>
    CyclesRepositoryImpl(
        ref.watch(cyclesDatabaseProvider), ref.watch(cyclesApiProvider)));

final essencesDatabaseProvider =
    Provider<EssencesDatabase>((_) => EssencesDatabaseImpl());
final essencesRepositoryProvider = Provider<EssencesRepository>(
    (ref) => EssencesRepositoryImpl(ref.watch(essencesDatabaseProvider)));

final arbresDatabaseProvider =
    Provider<ArbresDatabase>((_) => ArbresDatabaseImpl());
final arbresRepositoryProvider = Provider<ArbresRepository>(
    (ref) => ArbresRepositoryImpl(ref.watch(arbresDatabaseProvider)));

final arbresMesuresDatabaseProvider =
    Provider<ArbresMesuresDatabase>((_) => ArbresMesuresDatabaseImpl());
final arbresMesuresRepositoryProvider = Provider<ArbresMesuresRepository>(
    (ref) =>
        ArbresMesuresRepositoryImpl(ref.watch(arbresMesuresDatabaseProvider)));

final CorCyclePlacetteDatabaseProvider = Provider<CorCyclesPlacettesDatabase>(
    (_) => CorCyclesPlacettesDatabaseImpl());
final corCyclePlacetteRepositoryProvider =
    Provider<CorCyclesPlacettesRepository>((ref) =>
        CorCyclesPlacettesRepositoryImpl(
            ref.watch(CorCyclePlacetteDatabaseProvider)));
