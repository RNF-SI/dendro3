import 'dart:ffi';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/nomenclature.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/transect_id.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/transect_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      regeInfoObj['formType'],
      ref.watch(getEssencesUseCaseProvider),
      ref.watch(getStadeDureteNomenclaturesUseCaseProvider),
      ref.watch(getStadeEcorceNomenclaturesUseCaseProvider),
      transectListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class TransectSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final TransectListViewModel _transectListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  final GetStadeDureteNomenclaturesUseCase _getStadeDureteNomenclaturesUseCase;
  final GetStadeEcorceNomenclaturesUseCase _getStadeEcorceNomenclaturesUseCase;

  EssenceList? _essences;
  Future<List<Essence>>? essenceFuture;

  NomenclatureList? stadeDureteNomenclatures;
  Future<List<Nomenclature>>? stadeDureteFuture;

  NomenclatureList? stadeEcorceNomenclatures;
  Future<List<Nomenclature>>? stadeEcorceFuture;

  final String formType;

  final Ref ref;
  // Placette placette;
  // Cycle cycle;

  var _codeEssence = '';

  // late TransectId idTransect;
  late int? _idTransect;

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
    this.formType,
    this._getEssencesUseCase,
    this._getStadeDureteNomenclaturesUseCase,
    this._getStadeEcorceNomenclaturesUseCase,
    this._transectListViewModel,
    // this._insertArbreUseCase,
  ) {
    _initTransect(transect);

    essenceFuture = getAndSetInitialEssence();
    stadeEcorceFuture = getStadeEcorceNomenclatures();
    stadeDureteFuture = getStadeDureteNomenclatures();
  }

  Future<void> _getEssences() async {
    try {
      _essences = await _getEssencesUseCase.execute();
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Essence>> getAndSetInitialEssence() async {
    try {
      if (_essences == null) {
        await _getEssences();
      }

      // Assuming _essences is a Map or similar collection
      List<Essence> essenceList = _essences!.values.toList();

      return essenceList;
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Nomenclature>> getStadeDureteNomenclatures() async {
    try {
      stadeDureteNomenclatures ??=
          await _getStadeDureteNomenclaturesUseCase.execute();
      return stadeDureteNomenclatures!.values.toList();
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<Nomenclature>> getStadeEcorceNomenclatures() async {
    try {
      stadeEcorceNomenclatures ??=
          await _getStadeEcorceNomenclaturesUseCase.execute();
      return stadeEcorceNomenclatures!.values.toList();
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }

  _initTransect(final Transect? transect) {
    // _idPlacette = placette.idPlacette;
    if (formType == 'add') {
      _isNewTransect = true;
      _idTransect = null;
    } else {
      _idTransect = transect!.idTransect;
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
    // if (_isNewTransect) {
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
  }

  @override
  Future<void> updateObject() async {
    _transectListViewModel.updateItem({
      '_idTransect': _idTransect,
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
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      DropdownSearchConfig(
        fieldName: 'Essence',
        fieldRequired: true,
        asyncItems: (String filter, [Map<String, dynamic>? options]) =>
            getAndSetInitialEssence(),
        selectedItem: () {
          if (_codeEssence != '') {
            return _essences!.values
                .where((element) => element.codeEssence == _codeEssence)
                .first;
          }
          return null;
        },
        filterFn: (dynamic essence, filter) =>
            essence.essenceFilterByCodeEssence(filter),
        itemAsString: (dynamic e) => e.codeEssence,
        onChanged: (dynamic? data) =>
            data == null ? '' : setCodeEssence(data.codeEssence),
        validator: (dynamic? text, formData) => validateCodeEssence(),
        futureVariable: essenceFuture,
      ),
      TextFieldConfig(
        fieldName: 'refTransect',
        initialValue: _refTransect.toString(),
        hintText: 'Veuillez entrer le nom du transect',
      ),
      TextFieldConfig(
        fieldName: 'Distance',
        initialValue: initialDistanceValue(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _distance = double.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      TextFieldConfig(
        fieldName: 'Orientation',
        initialValue: initialOrientationValue(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _orientation = double.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      TextFieldConfig(
        fieldName: 'AzimutSouche',
        initialValue: initialAzimutSoucheValue(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _azimutSouche = double.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      TextFieldConfig(
        fieldName: 'DistanceSouche',
        initialValue: initialDistanceSoucheValue(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _distanceSouche = double.parse(value),
        hintText: 'Veuillez entrer le code',
      ),

      TextFieldConfig(
        fieldName: 'Diametre',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametre",
        onChanged: (value) => setDiametre(value),
        validator: (value, formData) {
          // Vérifier si la valeur en grade est entre 0 et 400
          // if (int.parse(value!) < 0 || int.parse(value) > 400) {
          //   return 'La valeur doit être entre 0 et 400 gr';
          // }
          return null;
        },
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'Diametre130',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametre",
        onChanged: (value) => setDiametre130(value),
        validator: (value, formData) {
          // Vérifier si la valeur en grade est entre 0 et 400
          // if (int.parse(value!) < 0 || int.parse(value) > 400) {
          //   return 'La valeur doit être entre 0 et 400 gr';
          // }
          return null;
        },
        initialValue: '',
      ),

      // TextFieldConfig(
      //   fieldName: 'Diametre',
      //   initialValue: initialDiametreValue(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _diametre = double.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),
      // TextFieldConfig(
      //   fieldName: 'Diametre130',
      //   initialValue: initialDiametre130Value(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _diametre130 = double.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),
      CheckboxFieldConfig(
        fieldName: 'RatioHauteur',
        initialValue: initialRatioHauteur(),
        onSaved: (value) => _ratioHauteur = value == 'true',
      ),
      CheckboxFieldConfig(
        fieldName: 'Contact',
        initialValue: initialContact(),
        onSaved: (value) => _contact = value == 'true',
      ),
      TextFieldConfig(
        fieldName: 'Angle',
        initialValue: initialAngleValue(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _angle = double.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      CheckboxFieldConfig(
        fieldName: 'Chablis',
        initialValue: initialChablis(),
        onSaved: (value) => _chablis = value == 'true',
      ),
      DropdownSearchConfig(
        fieldName: 'Stade Durete',
        fieldRequired: true,
        futureVariable: stadeDureteFuture,
        asyncItems: (String filter, [Map<String, dynamic>? options]) =>
            getStadeDureteNomenclatures(),
        selectedItem: () {
          if (_stadeDurete != null) {
            return stadeDureteNomenclatures!.values
                .where((element) => element.idNomenclature == _stadeDurete)
                .first;
          }
          return null;
        },
        filterFn: (dynamic essence, filter) {
          return true;
        },
        itemAsString: (dynamic e) => e.labelDefault,
        onChanged: (dynamic? data) =>
            data == null ? '' : setStadeDurete(data.idNomenclature),
      ),
      DropdownSearchConfig(
        fieldName: 'Stade Ecorce',
        fieldRequired: true,
        futureVariable: stadeEcorceFuture,
        asyncItems: (String filter, [Map<String, dynamic>? options]) =>
            getStadeEcorceNomenclatures(),
        selectedItem: () {
          if (_stadeEcorce != null) {
            return stadeEcorceNomenclatures!.values
                .where((element) => element.idNomenclature == _stadeEcorce)
                .first;
          }
          return null;
        },
        filterFn: (dynamic essence, filter) {
          return true;
        },
        itemAsString: (dynamic e) => e.labelDefault,
        onChanged: (dynamic? data) =>
            data == null ? '' : setStadeEcorce(data.idNomenclature),
      ),
      TextFieldConfig(
        fieldName: 'observation',
        hintText: "Veuillez entrer le observation",
        onChanged: (value) => setObservation(value),
        initialValue: '',
      ),
    ];
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
  setDiametre(final String value) => _diametre = double.parse(value);
  setDiametre130(final String value) => _diametre130 = double.parse(value);
  setRatioHauteur(final bool value) => _ratioHauteur = value;
  setContact(final bool value) => _contact = value;
  setAngle(final double value) => _angle = value;
  setChablis(final bool value) => _chablis = value;
  setStadeDurete(final int value) => _stadeDurete = value;
  setStadeEcorce(final int value) => _stadeEcorce = value;
  setObservation(final String value) => _observation = value;

  String initialDistanceValue() =>
      _distance != null ? _distance.toString() : '';
  String initialOrientationValue() =>
      _orientation != null ? _orientation.toString() : '';

  String initialAzimutSoucheValue() =>
      _azimutSouche != null ? _azimutSouche.toString() : '';

  String initialDistanceSoucheValue() =>
      _distanceSouche != null ? _distanceSouche.toString() : '';

  initialDiametreValue() {}

  initialDiametre130Value() {}

  bool initialRatioHauteur() => _ratioHauteur ?? false;

  bool initialContact() => _contact ?? false;

  String initialAngleValue() => _angle != null ? _angle.toString() : '';

  bool initialChablis() => _chablis ?? false;

  int initialStadeDureteValue() => _stadeDurete ?? 0;

  int initialStadeEcorceValue() => _stadeEcorce ?? 0;

  String? validateCodeEssence() {
    if (_codeEssence == '') {
      return 'Le champ code Essence est nécessaire.';
    } else
      return null;
  }
}
