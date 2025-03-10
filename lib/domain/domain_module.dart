import 'package:dendro3/data/data_module.dart';
import 'package:dendro3/domain/usecase/actualiser_cycles_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/actualiser_cycles_dispositif_usecase_impl.dart';
import 'package:dendro3/domain/usecase/export_database_in_accessible_location_usecase.dart';
import 'package:dendro3/domain/usecase/export_database_in_accessible_location_usecase_impl.dart';
import 'package:dendro3/domain/usecase/refresh_nomenclatures_usecase.dart';
import 'package:dendro3/domain/usecase/refresh_nomenclatures_usecase_impl.dart';
import 'package:dendro3/domain/usecase/request_storage_permission_usecase.dart';
import 'package:dendro3/domain/usecase/request_storage_permission_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_create_arbre_mesure_use_case.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_create_arbre_mesure_use_case_impl.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_create_bmSup30_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_create_bmSup30_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/clear_user_id_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/clear_user_id_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/clear_user_name_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/clear_user_name_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/complete_cycle_placette_created_usecase_impl.dart';
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
import 'package:dendro3/domain/usecase/delete_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_arbre_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_arbre_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_arbre_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/delete_bmSup30_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_database_usecase.dart';
import 'package:dendro3/domain/usecase/delete_database_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/delete_regeneration_usecase.dart';
import 'package:dendro3/domain/usecase/delete_regeneration_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_repere_usecase.dart';
import 'package:dendro3/domain/usecase/delete_repere_usecase_impl.dart';
import 'package:dendro3/domain/usecase/delete_transect_usecase.dart';
import 'package:dendro3/domain/usecase/delete_transect_usecase_impl.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase_impl.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/export_dispositif_data_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_code_ecolo_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_code_ecolo_nomenclature_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/domain/usecase/get_cor_cycle_placette_local_storage_provider_impl.dart';
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
import 'package:dendro3/domain/usecase/get_is_logged_in_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/get_is_logged_in_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase.dart';
import 'package:dendro3/domain/usecase/get_placette_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_terminal_name_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/get_terminal_name_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_user_id_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/get_user_id_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/get_user_name_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/get_user_name_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase_impl.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/is_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/is_cycle_placette_created_usecase_impl.dart';
import 'package:dendro3/domain/usecase/login_usecase.dart';
import 'package:dendro3/domain/usecase/login_usecase_impl.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase.dart';
import 'package:dendro3/domain/usecase/set_cycle_placette_created_usecase_impl.dart';
import 'package:dendro3/domain/usecase/set_is_logged_in_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/set_is_logged_in_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/set_terminal_name_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/set_terminal_name_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/set_user_id_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/set_user_id_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/set_user_name_from_local_storage_use_case.dart';
import 'package:dendro3/domain/usecase/set_user_name_from_local_storage_use_case_impl.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_arbre_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/update_bmSup30_and_mesure_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_cor_cycle_placette_usecase.dart';
import 'package:dendro3/domain/usecase/update_cor_cycle_placette_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_placette_usecase.dart';
import 'package:dendro3/domain/usecase/update_placette_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_regeneration_usecase.dart';
import 'package:dendro3/domain/usecase/update_regeneration_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_repere_usecase.dart';
import 'package:dendro3/domain/usecase/update_repere_usecase_impl.dart';
import 'package:dendro3/domain/usecase/update_transect_usecase.dart';
import 'package:dendro3/domain/usecase/update_transect_usecase_impl.dart';
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
    (ref) => DeleteDispositifUseCaseImpl(
        ref.watch(dispositifsRepositoryProvider),
        ref.watch(placettesRepositoryProvider),
        ref.watch(cyclesRepositoryProvider)));

final loginUseCaseProvider = Provider<LoginUseCase>(
    (ref) => LoginUseCaseImpl(ref.watch(authenticationRepositoryProvider)));

final getPlacetteUseCaseProvider = Provider<GetPlacetteUseCase>(
    (ref) => GetPlacetteUseCaseImpl(ref.watch(placettesRepositoryProvider)));

final updatePlacetteUseCaseProvider = Provider<UpdatePlacetteUseCase>(
    (ref) => UpdatePlacetteUseCaseImpl(ref.watch(placettesRepositoryProvider)));

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

final updateArbreAndCreateArbreMesureUseCaseProvider =
    Provider<UpdateArbreAndCreateArbreMesureUseCase>(
        (ref) => UpdateArbreAndCreateArbreMesureUseCaseImpl(
              ref.watch(arbresRepositoryProvider),
              ref.watch(arbresMesuresRepositoryProvider),
            ));

final updateBmSup30AndCreateBmSup30MesureUseCaseProvider =
    Provider<UpdateBmSup30AndCreateBmSup30MesureUseCase>(
        (ref) => UpdateBmSup30AndCreateBmSup30MesureUseCaseImpl(
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

final updateCorCyclePlacetteUseCaseProvider =
    Provider<UpdateCorCyclePlacetteUseCase>((ref) =>
        UpdateCorCyclePlacetteUseCaseImpl(
            ref.watch(corCyclePlacetteRepositoryProvider)));

final updateBmSup30AndMesureUseCaseProvider =
    Provider<UpdateBmSup30AndMesureUseCase>(
        (ref) => UpdateBmSup30AndMesureUseCaseImpl(
              ref.watch(bmsSup30RepositoryProvider),
              ref.watch(bmsSup30MesuresRepositoryProvider),
            ));

final createRepereUseCaseProvider = Provider<CreateRepereUseCase>(
    (ref) => CreateRepereUseCaseImpl(ref.watch(repereRepositoryProvider)));

final createRegenerationUseCaseProvider =
    Provider<CreateRegenerationUseCase>((ref) => CreateRegenerationUseCaseImpl(
          ref.watch(corCyclePlacetteRepositoryProvider),
          ref.watch(regenerationRepositoryProvider),
        ));

final createTransectUseCaseProvider =
    Provider<CreateTransectUseCase>((ref) => CreateTransectUseCaseImpl(
          ref.watch(corCyclePlacetteRepositoryProvider),
          ref.watch(transectRepositoryProvider),
        ));

final updateTransectUseCaseProvider =
    Provider<UpdateTransectUseCase>((ref) => UpdateTransectUseCaseImpl(
          ref.watch(corCyclePlacetteRepositoryProvider),
          ref.watch(transectRepositoryProvider),
        ));

final updateRegenerationUseCaseProvider =
    Provider<UpdateRegenerationUseCase>((ref) => UpdateRegenerationUseCaseImpl(
          ref.watch(corCyclePlacetteRepositoryProvider),
          ref.watch(regenerationRepositoryProvider),
        ));

final updateRepereUseCaseProvider =
    Provider<UpdateRepereUseCase>((ref) => UpdateRepereUseCaseImpl(
          ref.watch(repereRepositoryProvider),
        ));

final deleteArbreAndMesureUseCaseProvider =
    Provider<DeleteArbreAndMesureUseCase>((ref) =>
        DeleteArbreAndMesureUseCaseImpl(ref.watch(arbresRepositoryProvider),
            ref.watch(arbresMesuresRepositoryProvider)));

final deleteArbreMesureUseCaseProvider =
    Provider<DeleteArbreMesureUseCase>((ref) => DeleteArbreMesureUseCaseImpl(
          ref.watch(arbresRepositoryProvider),
          ref.watch(arbresMesuresRepositoryProvider),
        ));

final deleteBmSup30AndMesureUseCaseProvider =
    Provider<DeleteBmSup30AndMesureUseCase>((ref) =>
        DeleteBmSup30AndMesureUseCaseImpl(ref.watch(bmsSup30RepositoryProvider),
            ref.watch(bmsSup30MesuresRepositoryProvider)));

final deleteBmSup30MesureUseCaseProvider = Provider<DeleteBmSup30MesureUseCase>(
    (ref) => DeleteBmSup30MesureUseCaseImpl(
          ref.watch(bmsSup30RepositoryProvider),
          ref.watch(bmsSup30MesuresRepositoryProvider),
        ));

final deleteTransectUseCaseProvider =
    Provider<DeleteTransectUseCase>((ref) => DeleteTransectUseCaseImpl(
          ref.watch(corCyclePlacetteRepositoryProvider),
          ref.watch(transectRepositoryProvider),
        ));

final deleteRegenerationUseCaseProvider =
    Provider<DeleteRegenerationUseCase>((ref) => DeleteRegenerationUseCaseImpl(
          ref.watch(corCyclePlacetteRepositoryProvider),
          ref.watch(regenerationRepositoryProvider),
        ));

final deleteRepereUseCaseProvider =
    Provider<DeleteRepereUseCase>((ref) => DeleteRepereUseCaseImpl(
          ref.watch(repereRepositoryProvider),
        ));

final isCyclePlacetteCreatedUseCaseProvider =
    Provider<IsCyclePlacetteCreatedUseCase>((ref) =>
        IsCyclePlacetteCreatedUseCaseImpl(ref.watch(localStorageProvider)));

final setCyclePlacetteCreatedUseCaseProvider =
    Provider<SetCyclePlacetteCreatedUseCase>((ref) =>
        SetCyclePlacetteCreatedUseCaseImpl(ref.watch(localStorageProvider)));

final completeCyclePlacetteCreatedUseCaseProvider =
    Provider<CompleteCyclePlacetteCreatedUseCase>((ref) =>
        CompleteCyclePlacetteCreatedUseCaseImpl(
            ref.watch(localStorageProvider)));

final getCorCyclePlacetteLocalStorageUseCaseprovider =
    Provider<GetInProgressCorCyclePlacetteLocalStorageUseCase>((ref) =>
        GetInProgressCorCyclePlacetteLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final exportDispositifDataUseCaseProvider =
    Provider<ExportDispositifDataUseCase>(
  (ref) => ExportDispositifDataUseCaseImpl(
    ref.watch(dispositifsRepositoryProvider),
    ref.watch(arbresRepositoryProvider),
    ref.watch(bmsSup30RepositoryProvider),
    ref.watch(localStorageProvider),
  ),
);

final deleteDatabaseUseCaseProvider = Provider<DeleteDatabaseUseCase>((ref) =>
    DeleteDatabaseUseCaseImpl(ref.watch(globalDatabaseRepositoryProvider)));

final getUserIdFromLocalStorageUseCaseProvider =
    Provider<GetUserIdFromLocalStorageUseCase>((ref) =>
        GetUserIdFromLocalStorageUseCaseImpl(ref.watch(localStorageProvider)));

final setUserIdFromLocalStorageUseCaseProvider =
    Provider<SetUserIdFromLocalStorageUseCase>((ref) =>
        SetUserIdFromLocalStorageUseCaseImpl(ref.watch(localStorageProvider)));

final getUserNameFromLocalStorageUseCaseProvider =
    Provider<GetUserNameFromLocalStorageUseCase>((ref) =>
        GetUserNameFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final setUserNameFromLocalStorageUseCaseProvider =
    Provider<SetUserNameFromLocalStorageUseCase>((ref) =>
        SetUserNameFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final setTerminalNameFromLocalStorageUseCaseProvider =
    Provider<SetTerminalNameFromLocalStorageUseCase>((ref) =>
        SetTerminalNameFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final getTerminalNameFromLocalStorageUseCaseProvider =
    Provider<GetTerminalNameFromLocalStorageUseCase>((ref) =>
        GetTerminalNameFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final setIsLoggedInFromLocalStorageUseCaseProvider =
    Provider<SetIsLoggedInFromLocalStorageUseCase>((ref) =>
        SetIsLoggedInFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final getIsLoggedInFromLocalStorageUseCaseProvider =
    Provider<GetIsLoggedInFromLocalStorageUseCase>((ref) =>
        GetIsLoggedInFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final clearUserIdFromLocalStorageUseCaseProvider =
    Provider<ClearUserIdFromLocalStorageUseCase>((ref) =>
        ClearUserIdFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final clearUserNameFromLocalStorageUseCaseProvider =
    Provider<ClearUserNameFromLocalStorageUseCase>((ref) =>
        ClearUserNameFromLocalStorageUseCaseImpl(
            ref.watch(localStorageProvider)));

final exportDatabaseInAccessibleLocationUseCaseProvider =
    Provider<ExportDatabaseInAccessibleLocationUseCase>(
  (ref) => ExportDatabaseInAccessibleLocationUseCaseImpl(
    ref.watch(globalDatabaseRepositoryProvider),
  ),
);

final requestStoragePermissionUseCaseProvider =
    Provider<RequestStoragePermissionUseCase>(
        (ref) => RequestStoragePermissionUseCaseImpl());

final refreshNomenclaturesUseCaseProvider =
    Provider<RefreshNomenclaturesUseCase>(
  (ref) => RefreshNomenclaturesUseCaseImpl(
    ref.watch(globalDatabaseRepositoryProvider),
  ),
);
