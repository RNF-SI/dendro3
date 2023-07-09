import 'dart:ffi';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/transect_id.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/transect_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
//TODO: à clean et revoir lorsque ce sera fini

final transectSaisieViewModelProvider = Provider.autoDispose
    .family<TransectSaisieViewModel, Map<String, dynamic>>((ref, regeInfoObj) {
  final transectListViewModel =
      ref.watch(transectListViewModelStateNotifierProvider.notifier);
  return TransectSaisieViewModel(
      ref,
      // regeInfoObj['cycle'],
      // regeInfoObj['placette'],
      regeInfoObj['transect'],
      ref.watch(getEssencesUseCaseProvider),
      transectListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class TransectSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final TransectListViewModel _transectListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  late EssenceList _essences;
  Essence? _initialEssence = null;
  Essence? initialEssence = null;

  final Ref ref;
  // Placette placette;
  // Cycle cycle;

  var _codeEssence;

  late TransectId idTransect;

  int? _idCyclePlacette;
  int? _idTransectOrig;
  String? _refTransect;
  double? _distance;
  double? _orientation;
  double? _azimutSouche;
  double? _distanceSouche;
  double? _diametre;
  double? _diametre130;
  bool? _ratioHauteur;
  bool _contact = false;
  double? _angle;
  bool _chablis = false;
  int? _stadeDurete;
  int? _stadeEcorce;
  String? _observation;

  var _isNewTransect = false;

  TransectSaisieViewModel(
    this.ref,
    // this.cycle,
    // this.placette,
    final Transect? transect,
    this._getEssencesUseCase,
    this._transectListViewModel,
    // this._insertArbreUseCase,
  ) {
    _getEssences();

    _initTransect(transect);
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

  _initTransect(final Transect? transect) {
    // _idPlacette = placette.idPlacette;
    if (transect == null) {
      _isNewTransect = true;
    } else {
      _idCyclePlacette = transect.idCyclePlacette;
      _idTransectOrig = transect.idTransectOrig;
      _codeEssence = transect.codeEssence;
      _refTransect = transect.refTransect;
      _distance = transect.distance;
      _orientation = transect.orientation;
      _azimutSouche = transect.azimutSouche;
      _distanceSouche = transect.distanceSouche;
      _diametre = transect.diametre;
      _diametre130 = transect.diametre130;
      _ratioHauteur = transect.ratioHauteur;
      _contact = transect.contact;
      _angle = transect.angle;
      _chablis = transect.chablis;
      _stadeDurete = transect.stadeDurete;
      _stadeEcorce = transect.stadeEcorce;
      _observation = transect.observation;
    }
  }

  @override
  Future<void> createObject() async {
    if (_isNewTransect) {
      _transectListViewModel.addItem({
        '_idCyclePlacette': _idCyclePlacette,
        '_idTransectOrig': _idTransectOrig,
        '_codeEssence': _codeEssence,
        '_refTransect': _refTransect,
        '_distance': _distance,
        '_orientation': _orientation,
        '_azimutSouche': _azimutSouche,
        '_distanceSouche': _distanceSouche,
        '_diametre': _diametre,
        '_diametre130': _diametre130,
        '_ratioHauteur': _ratioHauteur,
        '_contact': _contact,
        '_angle': _angle,
        '_chablis': _chablis,
        '_stadeDurete': _stadeDurete,
        '_stadeEcorce': _stadeEcorce,
        '_observation': _observation,
      });
    } else {
      //   _transectListViewModel.updateItem({
      //   'idCyclePlacette': _idCyclePlacette,
      //   'sousPlacette': _sousPlacette,
      //   'codeEssence': _codeEssence,
      //   'recouvrement': _recouvrement,
      //   'classe1': _classe1,
      //   'classe2': _classe2,
      //   'classe3': _classe3,
      //   'taillis': _taillis,
      //   'abroutissement': _abroutissement,
      //   'idNomenclatureAbroutissement': _idNomenclatureAbroutissement,
      //   'observation': _observation,
      // });
      // });
    }
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [];
  }

  // fonction d'Initialisation
  initCodeEssence(final String value) => _codeEssence = value;
  initRefTransect(final String value) => _refTransect = value;
  initDistance(final double value) => _distance = value;
  initOrientation(final double value) => _orientation = value;
  initAzimutSouche(final double value) => _azimutSouche = value;
  initDistanceSouche(final double value) => _distanceSouche = value;
  initDiametre(final double value) => _diametre = value;
  initDiametre130(final double value) => _diametre130 = value;
  initRatioHauteur(final bool value) => _ratioHauteur = value;
  initContact(final bool value) => _contact = value;
  initAngle(final double value) => _angle = value;
  initChablis(final bool value) => _chablis = value;
  initStadeDurete(final int value) => _stadeDurete = value;
  initStadeEcorce(final int value) => _stadeEcorce = value;
  initObservation(final String value) => _observation = value;

  // Fonction setters
  setCodeEssence(final String value) => _codeEssence = value;
  setRefTransect(final String value) => _refTransect = value;
  setDistance(final double value) => _distance = value;
  setOrientation(final double value) => _orientation = value;
  setAzimutSouche(final double value) => _azimutSouche = value;
  setDistanceSouche(final double value) => _distanceSouche = value;
  setDiametre(final double value) => _diametre = value;
  setDiametre130(final double value) => _diametre130 = value;
  setRatioHauteur(final bool value) => _ratioHauteur = value;
  setContact(final bool value) => _contact = value;
  setAngle(final double value) => _angle = value;
  setChablis(final bool value) => _chablis = value;
  setStadeDurete(final int value) => _stadeDurete = value;
  setStadeEcorce(final int value) => _stadeEcorce = value;
  setObservation(final String value) => _observation = value;
}
