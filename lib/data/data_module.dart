import 'package:dendro3/data/datasource/implementation/api/cycles_api_impl.dart';
import 'package:dendro3/data/datasource/implementation/api/global_api_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/arbres_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/arbres_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/bmsSup30_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/bmsSup30_mesures_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/corCyclesPlacettes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/cycles_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/essences_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/global_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/nomenclatures_types_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/placettes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/regenerations_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/reperes_database_impl.dart';
import 'package:dendro3/data/datasource/implementation/database/transects_database_impl.dart';
import 'package:dendro3/data/datasource/interface/api/cycles_api.dart';
import 'package:dendro3/data/datasource/interface/api/global_api.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_database.dart';
import 'package:dendro3/data/datasource/interface/database/arbres_mesures_database.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_database.dart';
import 'package:dendro3/data/datasource/interface/database/bmsSup30_mesures_database.dart';
import 'package:dendro3/data/datasource/interface/database/corCyclesPlacettes_database.dart';
import 'package:dendro3/data/datasource/interface/database/cycles_database.dart';
import 'package:dendro3/data/datasource/interface/database/essences_database.dart';
import 'package:dendro3/data/datasource/interface/database/global_database.dart';
import 'package:dendro3/data/datasource/interface/database/nomenclatures_types_database.dart';
import 'package:dendro3/data/datasource/interface/database/placettes_database.dart';
import 'package:dendro3/data/datasource/interface/database/regenerations_database.dart';
import 'package:dendro3/data/datasource/interface/database/reperes_database.dart';
import 'package:dendro3/data/datasource/interface/database/transects_database.dart';
import 'package:dendro3/data/repository/arbre_repository_impl.dart';
import 'package:dendro3/data/repository/arbres_mesures_repository_impl.dart';
import 'package:dendro3/data/repository/bmSup30_repository_impl.dart';
import 'package:dendro3/data/repository/bmsSup30_mesures_repository_impl.dart';
import 'package:dendro3/data/repository/cor_cycles_placettes_repository_impl.dart';
import 'package:dendro3/data/repository/cycles_repository_impl.dart';
import 'package:dendro3/data/repository/dispositifs_repository_impl.dart';
import 'package:dendro3/data/repository/essences_repository_impl.dart';
import 'package:dendro3/data/repository/global_database_repository_impl.dart';
import 'package:dendro3/data/repository/local_storage_repository_impl.dart';
import 'package:dendro3/data/repository/nomenclatures_repository_impl.dart';
import 'package:dendro3/data/repository/nomenclatures_types_repository_impl.dart';
import 'package:dendro3/data/repository/placettes_repository_impl.dart';
import 'package:dendro3/data/repository/regenerations_repository_impl.dart';
import 'package:dendro3/data/repository/reperes_repository_impl.dart';
import 'package:dendro3/data/repository/transects_repository_impl.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/repository/arbres_repository.dart';
import 'package:dendro3/domain/repository/arbres_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_mesures_repository.dart';
import 'package:dendro3/domain/repository/bmsSup30_repository.dart';
import 'package:dendro3/domain/repository/cor_cycles_placettes_repository.dart';
import 'package:dendro3/domain/repository/cycles_repository.dart';
import 'package:dendro3/domain/repository/dispositifs_repository.dart';
import 'package:dendro3/data/repository/authentication_repository_impl.dart';
import 'package:dendro3/domain/repository/authentication_repository.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/repository/global_database_repository.dart';
import 'package:dendro3/domain/repository/local_storage_repository.dart';
import 'package:dendro3/domain/repository/nomenclatures_repository.dart';
import 'package:dendro3/domain/repository/nomenclatures_types_repository.dart';
import 'package:dendro3/domain/repository/placettes_repository.dart';
import 'package:dendro3/domain/repository/regenerations_repository.dart';
import 'package:dendro3/domain/repository/reperes_repository.dart';
import 'package:dendro3/domain/repository/transects_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'datasource/implementation/database/nomenclatures_database_impl.dart';
import 'datasource/interface/database/dispositifs_database.dart';
import 'datasource/implementation/database/dispositifs_database_impl.dart';
import 'datasource/interface/api/dispositifs_api.dart';
import 'datasource/implementation/api/dispositifs_api_impl.dart';
import 'datasource/interface/api/authentication_api.dart';
import 'datasource/implementation/api/authentication_api_impl.dart';
import 'datasource/interface/database/nomenclatures_database.dart';

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

final nomenclaturesDatabaseProvider =
    Provider<NomenclaturesDatabase>((_) => NomenclaturesDatabaseImpl());
final nomenclaturesRepositoryProvider = Provider<NomenclaturesRepository>(
    (ref) =>
        NomenclaturesRepositoryImpl(ref.watch(nomenclaturesDatabaseProvider)));

final nomenclaturesTypesDatabaseProvider = Provider<NomenclaturesTypesDatabase>(
    (_) => NomenclaturesTypesDatabaseImpl());
final nomenclaturesTypesRepositoryProvider =
    Provider<NomenclaturesTypesRepository>((ref) =>
        NomenclaturesTypesRepositoryImpl(
            ref.watch(nomenclaturesTypesDatabaseProvider)));

final arbresMesuresDatabaseProvider =
    Provider<ArbresMesuresDatabase>((_) => ArbresMesuresDatabaseImpl());
final arbresMesuresRepositoryProvider = Provider<ArbresMesuresRepository>(
    (ref) =>
        ArbresMesuresRepositoryImpl(ref.watch(arbresMesuresDatabaseProvider)));

final arbresDatabaseProvider =
    Provider<ArbresDatabase>((_) => ArbresDatabaseImpl());
final arbresRepositoryProvider = Provider<ArbresRepository>((ref) =>
    ArbresRepositoryImpl(ref.watch(arbresDatabaseProvider),
        ref.watch(arbresMesuresRepositoryProvider)));

final bmsSup30MesuresDatabaseProvider =
    Provider<BmsSup30MesuresDatabase>((_) => BmsSup30MesuresDatabaseImpl());
final bmsSup30MesuresRepositoryProvider = Provider<BmsSup30MesuresRepository>(
    (ref) => BmsSup30MesuresRepositoryImpl(
        ref.watch(bmsSup30MesuresDatabaseProvider)));

final bmsSup30DatabaseProvider =
    Provider<BmsSup30Database>((_) => BmsSup30DatabaseImpl());
final bmsSup30RepositoryProvider = Provider<BmsSup30Repository>((ref) =>
    BmsSup30RepositoryImpl(ref.watch(bmsSup30DatabaseProvider),
        ref.watch(bmsSup30MesuresRepositoryProvider)));

final RegenerationDatabaseProvider =
    Provider<RegenerationsDatabase>((_) => RegenerationsDatabaseImpl());
final regenerationRepositoryProvider = Provider<RegenerationsRepository>(
    (ref) =>
        RegenerationsRepositoryImpl(ref.watch(RegenerationDatabaseProvider)));

final TransectDatabaseProvider =
    Provider<TransectsDatabase>((_) => TransectsDatabaseImpl());
final transectRepositoryProvider = Provider<TransectsRepository>(
    (ref) => TransectsRepositoryImpl(ref.watch(TransectDatabaseProvider)));

final CorCyclePlacetteDatabaseProvider = Provider<CorCyclesPlacettesDatabase>(
    (_) => CorCyclesPlacettesDatabaseImpl());
final corCyclePlacetteRepositoryProvider =
    Provider<CorCyclesPlacettesRepository>((ref) =>
        CorCyclesPlacettesRepositoryImpl(
            ref.watch(CorCyclePlacetteDatabaseProvider),
            ref.watch(transectRepositoryProvider),
            ref.watch(regenerationRepositoryProvider)));

final RepereDatabaseProvider =
    Provider<ReperesDatabase>((_) => ReperesDatabaseImpl());
final repereRepositoryProvider = Provider<ReperesRepository>(
    (ref) => ReperesRepositoryImpl(ref.watch(RepereDatabaseProvider)));

final placettesProvider =
    Provider<PlacettesDatabase>((_) => PlacettesDatabaseImpl());
final placettesRepositoryProvider = Provider<PlacettesRepository>((ref) =>
    PlacettesRepositoryImpl(
        ref.watch(placettesProvider),
        ref.watch(arbresRepositoryProvider),
        ref.watch(bmsSup30RepositoryProvider),
        ref.watch(repereRepositoryProvider),
        ref.watch(corCyclePlacetteRepositoryProvider)));

final localStorageProvider =
    Provider<LocalStorageRepository>((ref) => LocalStorageRepositoryImpl());
