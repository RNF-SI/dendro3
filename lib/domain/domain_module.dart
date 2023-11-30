import 'package:dendro3/data/data_module.dart';
import 'package:dendro3/data/repository/essences_repository_impl.dart';
import 'package:dendro3/domain/repository/essences_repository.dart';
import 'package:dendro3/domain/usecase/actualiser_cycles_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/actualiser_cycles_dispositif_usecase_impl.dart';
import 'package:dendro3/domain/usecase/add_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/add_arbre_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/add_bmSup30_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/add_bmSup30_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/create_bmSup30_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_cor_cycle_placette_usecase.dart';
import 'package:dendro3/domain/usecase/create_cor_cycle_placette_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_regeneration_usecase.dart';
import 'package:dendro3/domain/usecase/create_regeneration_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_repere_usecase.dart';
import 'package:dendro3/domain/usecase/create_repere_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_transect_usecase.dart';
import 'package:dendro3/domain/usecase/create_transect_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_code_ecolo_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_code_ecolo_nomenclature_usecase_impl.dart';
// import 'package:dendro3/domain/usecase/create_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/create_dispositif_usecase_impl.dart';
// import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/delete_dispositif_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_from_api_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase_impl.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/login_usecase.dart';
import 'package:dendro3/domain/usecase/login_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_mesure_usecase_impl.dart';
// import 'package:dendro3/domain/usecase/update_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/update_dispositif_usecase_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'usecase/delete_dispositif_usecase_impl.dart';

final initLocalPSDRFDataBaseUseCaseProvider =
    Provider<InitLocalPSDRFDataBaseUseCase>((ref) =>
        InitLocalPSDRFDataBaseUseCaseImpl(
            ref.watch(globalDatabaseRepositoryProvider)));

final getDispositifListUseCaseProvider = Provider<GetDispositifListUseCase>(
    (ref) =>
        GetDispositifListUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));
final getDispositifListFromApiUseCaseProvider =
    Provider<GetDispositifListFromApiUseCase>((ref) =>
        GetDispositifListFromApiUseCaseImpl(
            ref.watch(dispositifsRepositoryProvider)));

final getUserDispositifListFromAPIUseCaseProvider =
    Provider<GetUserDispositifListFromAPIUseCase>((ref) =>
        GetUserDispositifListFromAPIUseCaseImpl(
            ref.watch(dispositifsRepositoryProvider)));

final getUserDispositifListFromDBUseCaseProvider =
    Provider<GetUserDispositifListFromDBUseCase>((ref) =>
        GetUserDispositifListFromDBUseCaseImpl(
            ref.watch(dispositifsRepositoryProvider)));

final downloadDispositifDataUseCaseProvider =
    Provider<DownloadDispositifDataUseCase>((ref) =>
        DownloadDispositifDataUseCaseImpl(
            ref.watch(dispositifsRepositoryProvider)));

final getDispositifUseCaseProvider = Provider<GetDispositifUseCase>((ref) =>
    GetDispositifUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));

final deleteDispositifUseCaseProvider = Provider<DeleteDispositifUseCase>(
    (ref) =>
        DeleteDispositifUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));

final loginUseCaseProvider = Provider<LoginUseCase>(
    (ref) => LoginUseCaseImpl(ref.watch(authenticationRepositoryProvider)));

final getPlacetteUseCaseProvider = Provider<GetPlacetteUseCase>(
    (ref) => GetPlacetteUseCaseImpl(ref.watch(placettesRepositoryProvider)));

final actualiserCyclesDispositifUseCaseProvider =
    Provider<ActualiserCyclesDispositifUseCase>((ref) =>
        ActualiserCyclesDispositifUseCaseImpl(
            ref.watch(cyclesRepositoryProvider)));

final getEssencesUseCaseProvider = Provider<GetEssencesUseCase>(
    (ref) => GetEssencesUseCaseImpl(ref.watch(essencesRepositoryProvider)));

final getStadeDureteNomenclaturesUseCaseProvider =
    Provider<GetStadeDureteNomenclaturesUseCase>((ref) =>
        GetStadeDureteNomenclaturesUseCaseImpl(
            ref.watch(nomenclaturesRepositoryProvider),
            ref.watch(nomenclaturesTypesRepositoryProvider)));

final getStadeEcorceNomenclaturesUseCaseProvider =
    Provider<GetStadeEcorceNomenclaturesUseCase>((ref) =>
        GetStadeEcorceNomenclaturesUseCaseImpl(
            ref.watch(nomenclaturesRepositoryProvider),
            ref.watch(nomenclaturesTypesRepositoryProvider)));

final getCodeEcoloNomenclaturesUseCaseProvider =
    Provider<GetCodeEcoloNomenclaturesUseCase>((ref) =>
        GetCodeEcoloNomenclaturesUseCaseImpl(
            ref.watch(nomenclaturesRepositoryProvider),
            ref.watch(nomenclaturesTypesRepositoryProvider)));

final createArbreAndMesureUseCaseProvider =
    Provider<CreateArbreAndMesureUseCase>(
        (ref) => CreateArbreAndMesureUseCaseImpl(
              ref.watch(arbresRepositoryProvider),
              ref.watch(arbresMesuresRepositoryProvider),
            ));

final updateArbreAndMesureUseCaseProvider =
    Provider<UpdateArbreAndMesureUseCase>(
        (ref) => UpdateArbreAndMesureUseCaseImpl(
              ref.watch(arbresRepositoryProvider),
              ref.watch(arbresMesuresRepositoryProvider),
            ));

final addArbreMesureUseCaseProvider =
    Provider<AddArbreMesureUseCase>((ref) => AddArbreMesureUseCaseImpl(
          ref.watch(arbresRepositoryProvider),
          ref.watch(arbresMesuresRepositoryProvider),
        ));

final addBmSup30MesureUseCaseProvider =
    Provider<AddBmSup30MesureUseCase>((ref) => AddBmSup30MesureUseCaseImpl(
          ref.watch(bmsSup30RepositoryProvider),
          ref.watch(bmsSup30MesuresRepositoryProvider),
        ));

final createBmSup30AndMesureUseCaseProvider =
    Provider<CreateBmSup30AndMesureUseCase>((ref) =>
        CreateBmSup30AndMesureUseCaseImpl(ref.watch(bmsSup30RepositoryProvider),
            ref.watch(bmsSup30MesuresRepositoryProvider)));

final createCorCyclePlacetteUseCaseProvider =
    Provider<CreateCorCyclePlacetteUseCase>((ref) =>
        CreateCorCyclePlacetteUseCaseImpl(
            ref.watch(corCyclePlacetteRepositoryProvider)));

final updateBmSup30AndMesureUseCaseProvider =
    Provider<UpdateBmSup30AndMesureUseCase>(
        (ref) => UpdateBmSup30AndMesureUseCaseImpl(
              ref.watch(bmsSup30RepositoryProvider),
              ref.watch(bmsSup30MesuresRepositoryProvider),
            ));

final createRepereUseCaseProvider = Provider<CreateRepereUseCase>(
    (ref) => CreateRepereUseCaseImpl(ref.watch(repereRepositoryProvider)));

final createRegenerationUseCaseProvider = Provider<CreateRegenerationUseCase>(
    (ref) => CreateRegenerationUseCaseImpl(
        ref.watch(regenerationRepositoryProvider)));

final createTransectUseCaseProvider = Provider<CreateTransectUseCase>(
    (ref) => CreateTransectUseCaseImpl(ref.watch(transectRepositoryProvider)));
