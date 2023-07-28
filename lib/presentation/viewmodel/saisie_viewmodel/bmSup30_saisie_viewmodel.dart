import 'dart:ffi';

import 'package:dendro3/data/entity/bmsSup30_entity.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/bmSup30Mesure.dart';
// import 'package:dendro3/domain/model/bmSup30_id.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/create_bmSup30_and_mesure_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/bms_list_viewmodel.dart';
// import 'package:dendro3/presentation/viewmodel/baseList/bmSup30_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:dendro3/presentation/state/state.dart';

//TODO: à clean et revoir lorsque ce sera fini

final bmsup30SaisieViewModelProvider = Provider.autoDispose
    .family<BmSup30SaisieViewModel, Map<String, dynamic>>(
        (ref, bmsup30InfoObj) {
  final bmsup30ListViewModel =
      ref.watch(bmSup30ListViewModelStateNotifierProvider.notifier);
  return BmSup30SaisieViewModel(
      ref,
      bmsup30InfoObj['cycle'],
      bmsup30InfoObj['placette'],
      bmsup30InfoObj['bmsup30'],
      bmsup30InfoObj['bmsup30Mesure'],
      ref.watch(getEssencesUseCaseProvider),
      bmsup30ListViewModel);
});

class BmSup30SaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final BmSup30ListViewModel _bmsup30ListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  // final InsertBmSup30UseCase _insertBmSup30UseCase;
  final Ref ref;

  late EssenceList _essences;
  Essence? _initialEssence = null;
  Essence? initialEssence = null;
  Placette placette;
  Cycle cycle;

  // late BmSup30Id _idBmSup30;
  // var _idBmSup30Orig;
  var _idPlacette;
  var _idArbre;
  var _codeEssence = '';
  double? _azimut;
  double? _distance;
  double? _orientation;
  double? _azimutSouche;
  double? _distanceSouche;
  var _observation = '';
  var _isNewBmSup30 = false;

  // late BmSup30MesureId idBmSup30Mesure='';
  // var _idBmSup30 = '';
  int? _idCycle;
  double? _diametreIni;
  double? _diametreMed;
  double? _diametreFin;
  double? _diametre130;
  double? _longueur;
  bool _ratioHauteur = false;
  double? _contact;
  bool _chablis = false;
  int? _stadeDurete;
  int? _stadeEcorce;
  var _isNewBmSup30Mesure = false;
  var _observationMesure = '';

  BmSup30SaisieViewModel(
    this.ref,
    this.cycle,
    this.placette,
    final BmSup30? bmsup30,
    final BmSup30Mesure? bmsup30Mesure,
    this._getEssencesUseCase,
    this._bmsup30ListViewModel,
    // this._insertBmSup30UseCase,
  ) {
    _getEssences();
    // _essences = await _getEssencesUseCase.execute();
    _initBmSup30(bmsup30);
    _initBmSup30Mesure(bmsup30Mesure);
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

  _initBmSup30(final BmSup30? bmsup30) {
    _idPlacette = placette.idPlacette;
    if (bmsup30 == null) {
      _isNewBmSup30 = true;
    } else {
      // Init BmSup30Infos
      // _idBmSup30Orig = bmsup30.idBmSup30Orig;
      _idArbre = bmsup30.idArbre;
      _codeEssence = bmsup30.codeEssence;
      _azimut = bmsup30.azimut;
      _distance = bmsup30.distance;
      _orientation = bmsup30.orientation;
      _azimutSouche = bmsup30.azimutSouche;
    }
  }

  _initBmSup30Mesure(final BmSup30Mesure? bmsup30Mesure) {
    _idCycle = cycle.idCycle;
    if (bmsup30Mesure == null) {
      _isNewBmSup30Mesure = true;
    } else {
      // Init BmSup30Infos
      _idCycle = bmsup30Mesure.idCycle;
      _diametreIni = bmsup30Mesure.diametreIni;
      _diametreMed = bmsup30Mesure.diametreMed;
      _diametreFin = bmsup30Mesure.diametreFin;
      _longueur = bmsup30Mesure.longueur!;
      _ratioHauteur = bmsup30Mesure.ratioHauteur!;
      _contact = bmsup30Mesure.contact;
      _chablis = bmsup30Mesure.chablis!;
      _observation = bmsup30Mesure.observation!;
    }
  }

  Future<void> createObject() async {
    if (_isNewBmSup30) {
      _bmsup30ListViewModel.addItem({
        'idPlacette': _idPlacette,
        'idArbre': _idArbre,
        'codeEssence': _codeEssence,
        'azimut': _azimut,
        'distance': _distance,
        'orientation': _orientation,
        'azimutSouche': _azimutSouche,
        'distanceSouche': _distanceSouche,
        'observation': _observation,
        'idCycle': _idCycle,
        'diametreIni': _diametreIni,
        'diametreMed': _diametreMed,
        'diametreFin': _diametreFin,
        'diametre130': _diametre130,
        'longueur': _longueur,
        'ratioHauteur': _ratioHauteur,
        'contact': _contact,
        'chablis': _chablis,
        'stadeDurete': _stadeDurete,
        'stadeEcorce': _stadeEcorce,
        'observationMesure': _observationMesure,
      });
    } else {}
  }

  String initialIdPlacetteValue() => _idPlacette.toString();
  String initialIdArbreValue() => _idArbre.toString();
  String initialAzimutValue() => _azimut != null ? _azimut.toString() : '';
  String initialDistanceValue() =>
      _distance != null ? _distance.toString() : '';

  String initialObservationValue() => _observation ?? '';

  int initialStadeDureteValue() => _stadeDurete ?? 0;
  int initialStadeEcorceValue() => _stadeEcorce ?? 0;

  String initialOrientationValue() =>
      _orientation != null ? _orientation.toString() : '';

  String initialAzimutSoucheValue() =>
      _azimutSouche != null ? _azimutSouche.toString() : '';

  String initialDistanceSouche() =>
      _distanceSouche != null ? _distanceSouche.toString() : '';

  // bool initialLimiteValue() => _taillis ?? true;
  bool initialRatioHauteurValue() => _ratioHauteur ?? true;
  bool initialChablisValue() => _chablis ?? true;

  bool shouldShowDeleteTodoIcon() => !_isNewBmSup30;

  setCodeEssence(final String value) => _codeEssence = value;

  // setters BmSup30
  setAzimut(final String value) => _azimut = double.parse(value);
  setDistance(final String value) => _distance = double.parse(value);
  setOrientation(final String value) => _orientation = double.parse(value);
  setAzimutSouche(final String value) => _orientation = double.parse(value);
  setDistanceSouche(final String value) => _orientation = double.parse(value);
  setObservation(final String value) => _observation = value;

  // setters BmSup30Mesure
  setDiametreIni(final String value) => _diametreIni = double.parse(value);
  setDiametreMed(final String value) => _diametreMed = double.parse(value);
  setDiametreFin(final String value) => _diametreFin = double.parse(value);
  setDiametre130(final String value) => _diametre130 = double.parse(value);
  setLongueur(final String value) => _longueur = double.parse(value);
  setRatioHauteur(final bool value) => _ratioHauteur = value;
  setContact(final String value) => _contact = double.parse(value);
  setChablis(final bool value) => _chablis = value;
  setStadeDurete(final int value) => _stadeDurete = value;
  setStadeEcorce(final int value) => _stadeEcorce = value;
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
    } else if (_distance! < 0 || _distance! > 100) {
      return 'La valeur doit être entre 0 et 100';
    } else {
      return null;
    }
  }

  String? validateDistanceSouche() {
    if (_distance == null) {
      return 'Enter a distance.';
    } else if (_distance! < 0 || _distance! > 100) {
      return 'La valeur doit être entre 0 et 100';
    } else {
      return null;
    }
  }

  String? validateAzimutSouche() {
    if (_azimut == null) {
      return 'Enter a azimut.';
    } else if (_azimut! < 0 || _azimut! > 400) {
      return 'La valeur doit être entre 0 et 400 gr';
    } else {
      return null;
    }
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      TextFieldConfig(
        fieldName: 'IdPlacette',
        initialValue: initialIdPlacetteValue(),
        isEditable: false,
        hintText: 'Veuillez entrer le code',
        // validator: ...,
      ),
      TextFieldConfig(
        fieldName: 'idArbre',
        initialValue: initialIdArbreValue(),
        isEditable: false,
        hintText: 'Veuillez entrer le code',
        // validator: ...,
      ),
      DropdownSearchConfig(
        fieldName: 'Code Essence',
        asyncItems: (String filter) => getEssences(),
        selectedItem: initialEssence,
        filterFn: (dynamic essence, filter) =>
            essence.essenceFilterByCodeEssence(filter),
        itemAsString: (dynamic e) => e.codeEssence,
        onChanged: (dynamic? data) =>
            data == null ? '' : setCodeEssence(data.codeEssence),
      ),
      TextFieldConfig(
        fieldName: 'Azimut',
        initialValue: initialAzimutValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (String? text) => validateAzimut(),
        hintText: "Veuillez entrer l'azimut",
        onChanged: (value) => setAzimut(value),
      ),
      TextFieldConfig(
        fieldName: 'Orientation',
        initialValue: initialOrientationValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        validator: (String? text) => validateDistance(),
        hintText: "Veuillez entrer l'orientation",
        onChanged: (value) => setDistance(value),
      ),
      TextFieldConfig(
        fieldName: 'Azimut Souche',
        initialValue: initialAzimutSoucheValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        validator: (String? text) => validateAzimutSouche(),
        hintText: "Veuillez entrer l'azimut souche",
        onChanged: (value) => setAzimutSouche(value),
      ),
      TextFieldConfig(
        fieldName: 'Distance Souche',
        initialValue: initialDistanceSouche(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        validator: (String? text) => validateDistanceSouche(),
        hintText: "Veuillez entrer la distance souche",
        onChanged: (value) => setDistanceSouche(value),
      ),
      TextFieldConfig(
        fieldName: 'Observation',
        initialValue: initialObservationValue(),
        hintText: "Veuillez entrer l'observation",
        onChanged: (value) => setObservation(value),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      TextFieldConfig(
        fieldName: 'DiametreIni',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametreini",
        onChanged: (value) => setDiametreIni(value),
        validator: (value) {
          // Vérifier si la valeur en grade est entre 0 et 400
          // if (int.parse(value!) < 0 || int.parse(value) > 400) {
          //   return 'La valeur doit être entre 0 et 400 gr';
          // }
          return null;
        },
        initialValue: '',
      ),
      TextFieldConfig(
        fieldName: 'DiametreMed',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametremed",
        onChanged: (value) => setDiametreMed(value),
        validator: (value) {
          // Vérifier si la valeur en grade est entre 0 et 400
          // if (int.parse(value!) < 0 || int.parse(value) > 400) {
          //   return 'La valeur doit être entre 0 et 400 gr';
          // }
          return null;
        },
        initialValue: '',
      ),
      TextFieldConfig(
        fieldName: 'DiametreFin',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametrefin",
        onChanged: (value) => setDiametreFin(value),
        validator: (value) {
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
        hintText: "Veuillez entrer le diametre130",
        onChanged: (value) => setDiametre130(value),
        validator: (value) {
          // Vérifier si la valeur en grade est entre 0 et 400
          // if (int.parse(value!) < 0 || int.parse(value) > 400) {
          //   return 'La valeur doit être entre 0 et 400 gr';
          // }
          return null;
        },
        initialValue: '',
      ),
      TextFieldConfig(
        fieldName: 'Longueur',
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le longueur",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setLongueur(value),
      ),
      CheckboxFieldConfig(
        fieldName: 'ratioHauteur',
        initialValue: initialRatioHauteurValue(),
        onSaved: (value) => setRatioHauteur(value!),
      ),
      TextFieldConfig(
        fieldName: 'Contact',
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le contact",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setContact(value),
      ),
      CheckboxFieldConfig(
        fieldName: 'chablis',
        initialValue: initialChablisValue(),
        onSaved: (value) => setChablis(value!),
      ),
      DropdownFieldConfig<dynamic>(
        fieldName: 'stadeDurete',
        value: _stadeDurete,
        items: ['', '1', '2', '3', '4', '5'],
        onChanged: (value) => setStadeDurete(initialStadeDureteValue()),
      ),
      DropdownFieldConfig<dynamic>(
        fieldName: 'stadeEcorce',
        value: _stadeEcorce,
        items: ['', '1', '2', '3', '4'],
        onChanged: (value) => setStadeEcorce(initialStadeEcorceValue()),
      ),
      TextFieldConfig(
        fieldName: 'observation',
        hintText: "Veuillez entrer le observation",
        onChanged: (value) => setObservation(value),
        initialValue: '',
      ),
    ];
  }
}
