import 'dart:ffi';

import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/viewmodel/arbrelist/arbre_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:dendro3/presentation/state/state.dart';

//TODO: à clean et revoir lorsque ce sera fini

// final saisiePlacetteViewModelProvider = StateNotifierProvider.autoDispose
//     .family<SaisiePlacetteViewModel, custom_async_state.State<Placette>, int>(
//         (ref, placetteId) {
//   return SaisiePlacetteViewModel(
//     placetteId,
//     ref.watch(getPlacetteUseCaseProvider),
//   );
// });

final formSaisieViewModelProvider = Provider.autoDispose
    .family<FormSaisieViewModel, Map<String, dynamic>>((ref, arbreInfoObj) {
  final arbreListViewModel =
      ref.watch(arbreListViewModelStateNotifierProvider.notifier);
  return FormSaisieViewModel(
      ref,
      arbreInfoObj['cycle'],
      arbreInfoObj['placette'],
      arbreInfoObj['arbre'],
      arbreInfoObj['arbreMesure'],
      ref.watch(getEssencesUseCaseProvider),
      arbreListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class FormSaisieViewModel {
  late final ArbreListViewModel _arbreListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  // final InsertArbreUseCase _insertArbreUseCase;
  final Ref ref;
  // late TodoId _id;
  // var _title = '';
  // var _description = '';
  // var _isCompleted = false;
  // var _dueDate = DateTime.now();
  late EssenceList _essences;
  Essence? _initialEssence = null;
  Essence? initialEssence = null;
  Placette placette;
  Cycle cycle;

  late ArbreId _idArbre;
  // var _idArbreOrig;
  var _idPlacette;
  var _codeEssence = '';
  double? _azimut;
  double? _distance;
  bool _taillis = false;
  var _observation = '';
  var _isNewArbre = false;

  // late ArbreMesureId idArbreMesure='';
  // var _idArbre = '';
  int? _idCycle;
  double? _diametre1;
  double? _diametre2;
  var _type = '';
  double? _hauteurTotale;
  double? _hauteurBranche;
  int? _stadeDurete;
  int? _stadeEcorce;
  var _liane = '';
  double? _diametreLiane;
  var _coupe = '';
  bool _limite = false;
  int? _idNomenclatureCodeSanitaire;
  var _codeEcolo = '';
  var _refCodeEcolo = '';
  bool _ratioHauteur = false;
  var _observationMesure = '';
  var _isNewArbreMesure = false;

  FormSaisieViewModel(
    this.ref,
    this.cycle,
    this.placette,
    final Arbre? arbre,
    final ArbreMesure? arbreMesure,
    this._getEssencesUseCase,
    this._arbreListViewModel,
    // this._insertArbreUseCase,
  ) {
    _getEssences();
    // _essences = await _getEssencesUseCase.execute();
    _initArbre(arbre);
    _initArbreMesure(arbreMesure);
  }

  Future<void> _getEssences() async {
    try {
      _essences = await _getEssencesUseCase.execute();
      _initialEssence = _essences.values
          .where((element) => element.codeEssence == _codeEssence)
          .first;
      initialEssence = _essences.values
          .where((element) => element.codeEssence == _codeEssence)
          .first;
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Essence>> getEssences() async {
    try {
      var essences = await _getEssencesUseCase.execute();
      return essences.values.toList();
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }

  _initArbre(final Arbre? arbre) {
    _idPlacette = placette.idPlacette;
    if (arbre == null) {
      _isNewArbre = true;
    } else {
      // Init ArbreInfos
      // _idArbreOrig = arbre.idArbreOrig;
      _codeEssence = arbre.codeEssence;
      _azimut = arbre.azimut;
      _distance = arbre.distance;
      _taillis = arbre.taillis ?? true;
      _observation = arbre.observation!;
      // _isNewArbre

      // Init ArbreMesure
      // _idArbre = arbre.arbresMesures.;

      // _id = todo.id;
      // _title = todo.title;
      // _description = todo.description;
      // _isCompleted = todo.isCompleted;
      // _dueDate = todo.dueDate;
    }
  }

  _initArbreMesure(final ArbreMesure? arbreMesure) {
    _idCycle = cycle.idCycle;
    if (arbreMesure == null) {
      _isNewArbreMesure = true;
    } else {
      // Init ArbreInfos
      _idCycle = arbreMesure.idCycle;
      _diametre1 = arbreMesure.diametre1;
      _diametre2 = arbreMesure.diametre2;
      _type = arbreMesure.type!;
      _hauteurTotale = arbreMesure.hauteurTotale;
      _hauteurBranche = arbreMesure.hauteurBranche;
      _stadeDurete = arbreMesure.stadeDurete!;
      _stadeEcorce = arbreMesure.stadeEcorce!;
      _liane = arbreMesure.liane!;
      _diametreLiane = arbreMesure.diametreLiane;
      _coupe = arbreMesure.coupe!;
      _limite = arbreMesure.limite ?? false;
      _idNomenclatureCodeSanitaire = arbreMesure.idNomenclatureCodeSanitaire!;
      _codeEcolo = arbreMesure.codeEcolo!;
      _refCodeEcolo = arbreMesure.refCodeEcolo!;
      _ratioHauteur = arbreMesure.ratioHauteur ?? false;
      _observationMesure = arbreMesure.observation!;
    }
  }

  Future<void> createOrUpdateArbre() async {
    if (_isNewArbre) {
      _arbreListViewModel.addArbre(
        _idPlacette,
        _codeEssence,
        _azimut!,
        _distance!,
        _taillis,
        _observation,
        _idCycle,
        _diametre1,
        _diametre2,
        _type,
        _hauteurTotale,
        _hauteurBranche,
        _stadeDurete,
        _stadeEcorce,
        _liane,
        _diametreLiane,
        _coupe,
        _limite,
        _idNomenclatureCodeSanitaire,
        _codeEcolo,
        _refCodeEcolo,
        _ratioHauteur,
        _observationMesure,
      );
    } else {
      // final newTodo = Todo(
      //   id: _id,
      //   title: _title,
      //   description: _description,
      //   isCompleted: _isCompleted,
      //   dueDate: _dueDate,
      // );
      // _todoListViewModel.updateTodo(newTodo);
      // final newTodo = Todo(
      //   id: _id,
      //   title: _title,
      //   description: _description,
      //   isCompleted: _isCompleted,
      //   dueDate: _dueDate,
      // );
      // _todoListViewModel.updateTodo(newTodo);
    }
    // try {
    //   await _insertArbreUseCase.execute(arbreEntity);
    // } on Exception catch (e) {
    //   print(e);
    // } catch (e) {
    //   print(e);
    // }
  }
  // Future<void> _init(int placetteId) async {
  //   state = const custom_async_state.State.loading();
  //   try {
  //     var placette = await _getPlacetteUseCase.execute(placetteId);
  //     state = custom_async_state.State.success(placette);
  //   } on Exception catch (e) {
  //     state = custom_async_state.State.error(e);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Essence initialCodeEssenceValue() => _essences.values
  //     .where((element) => element.codeEssence == _codeEssence)
  //     .first;
  // Essence initialCodeEssenceValue() => _initialEssence;
  String initialIdPlacetteValue() => _idPlacette.toString();
  String initialAzimutValue() => _azimut != null ? _azimut.toString() : '';
  String initialDistanceValue() =>
      _distance != null ? _distance.toString() : '';
  bool initialTaillisValue() => _taillis ?? true;
  String initialObservationValue() => _observation ?? '';

  // String initialDescriptionValue() => _description;

  // DateTime initialDueDateValue() => _dueDate;

  // DateTime datePickerFirstDate() => DateTime(DateTime.now().year - 5, 1, 1);

  // DateTime datePickerLastDate() => DateTime(DateTime.now().year + 5, 12, 31);

  bool shouldShowDeleteTodoIcon() => !_isNewArbre;

  setCodeEssence(final String value) => _codeEssence = value;
  // setters Arbre
  setAzimut(final String value) => _azimut = double.parse(value);
  setDistance(final String value) => _distance = double.parse(value);
  setTaillis(final bool value) => _taillis = value;
  setObservation(final String value) => _observation = value;

  // setters ArbreMesure
  setDiametre1(final String value) => _diametre1 = double.parse(value);
  setDiametre2(final String value) => _diametre2 = double.parse(value);
  setType(final String value) => _type = value;
  setHauteurTotale(final String value) => _hauteurTotale = double.parse(value);
  setHauteurBranche(final String value) =>
      _hauteurBranche = double.parse(value);
  setStadeDurete(final int value) => _stadeDurete = value;
  setStadeEcorce(final int value) => _stadeEcorce = value;
  setLiane(final String value) => _liane = value;
  setDiametreLiane(final String value) => _diametreLiane = double.parse(value);
  setCoupe(final String value) => _coupe = value;
  setLimite(final bool value) => _limite = value;
  setIdNomenclatureCodeSanitaire(final int value) =>
      _idNomenclatureCodeSanitaire = value;
  setCodeEcolo(final String value) => _codeEcolo = value;
  setRefCodeEcolo(final String value) => _refCodeEcolo = value;
  setRatioHauteur(final bool value) => _ratioHauteur = value;
  setObservationMesure(final String value) => _observationMesure = value;

  String? validateAzimut() {
    if (_azimut == null) {
      return 'Enter a azimut.';
    } else if (_azimut! < 0 || _azimut! > 400) {
      return 'La valeur doit être entre 0 et 400 gr';
    } else {
      return null;
    }
  }

  String? validateDistance() {
    if (_distance == null) {
      return 'Enter a distance.';
    } else if (_distance! < 0 || _distance! > 40) {
      return 'La valeur doit être entre 0 et 40';
    } else {
      return null;
    }
  }
  // String? validateTitle() {
  //   if (_title.isEmpty) {
  //     return 'Enter a title.';
  //   } else if (_title.length > 20) {
  //     return 'Limit the title to 20 characters.';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validateDescription() {
  //   if (_description.length > 100) {
  //     return 'Limit the description to 100 characters.';
  //   } else {
  //     return null;
  //   }
  // }

  // String? validateDueDate() {
  //   if (_isNewTodo && _dueDate.isBefore(DateTime.now())) {
  //     return "DueDate must be after today's date.";
  //   } else {
  //     return null;
  //   }
  // }
}
