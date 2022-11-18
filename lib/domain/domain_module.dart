import 'package:dendro3/data/data_module.dart';
// import 'package:dendro3/domain/usecase/create_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/create_dispositif_usecase_impl.dart';
// import 'package:dendro3/domain/usecase/delete_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/delete_dispositif_usecase_impl.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_usecase.dart';
import 'package:dendro3/domain/usecase/get_dispositif_list_usecase_impl.dart';
// import 'package:dendro3/domain/usecase/update_dispositif_usecase.dart';
// import 'package:dendro3/domain/usecase/update_dispositif_usecase_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getDispositifListUseCaseProvider = Provider<GetDispositifListUseCase>(
    (ref) =>
        GetDispositifListUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));
// final createDispositifUseCaseProvider = Provider<CreateDispositifUseCase>(
//     (ref) =>
//         CreateDispositifUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));
// final updateDispositifUseCaseProvider = Provider<UpdateDispositifUseCase>(
//     (ref) =>
//         UpdateDispositifUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));
// final deleteDispositifUseCaseProvider = Provider<DeleteDispositifUseCase>(
//     (ref) =>
//         DeleteDispositifUseCaseImpl(ref.watch(dispositifsRepositoryProvider)));
