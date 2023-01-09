import 'package:dendro3/data/data_module.dart';
import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase.dart';
import 'package:dendro3/domain/usecase/download_dispositif_data_usecase_impl.dart';
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
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_api_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase.dart';
import 'package:dendro3/domain/usecase/get_user_dispositif_list_from_db_usecase_impl.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase.dart';
import 'package:dendro3/domain/usecase/init_local_PSDRF_database_usecase_impl.dart';
import 'package:dendro3/domain/usecase/login_usecase.dart';
import 'package:dendro3/domain/usecase/login_usecase_impl.dart';
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
