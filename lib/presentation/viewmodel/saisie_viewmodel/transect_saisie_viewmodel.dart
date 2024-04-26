import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/nomenclature.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/transect_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
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
      regeInfoObj['corCyclePlacette'],
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

  CorCyclePlacette? corCyclePlacette;

  final String formType;

  final Ref ref;
  // Placette placette;
  // Cycle cycle;

  var _codeEssence = '';

  // late TransectId idTransect;
  late String? _idTransect;

  String? _idCyclePlacette;
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
    this.corCyclePlacette,
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
      _diametre = transect.diametre;
      _idTransectOrig = transect.idTransectOrig;
      _codeEssence = transect.codeEssence;
      _refTransect = transect.refTransect;
      _distance = transect.distance;
      _orientation = transect.orientation;
      _azimutSouche = transect.azimutSouche;
      _distanceSouche = transect.distanceSouche;
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

  String initialDiametreValue() {
    if (_diametre == null) {
      return '';
    }
    return _diametre == _diametre!.toInt()
        ? _diametre!.toInt().toString()
        : _diametre!.toStringAsFixed(1);
  }

  String initialAngleValue() {
    if (_angle == null) {
      return '';
    }
    return _angle == _angle!.toInt()
        ? _angle!.toInt().toString()
        : _angle!.toStringAsFixed(1);
  }

  @override
  Future<String> createObject() async {
    // if (_isNewTransect) {
    _transectListViewModel.addItem({
      'idCyclePlacette': corCyclePlacette!.idCyclePlacette,
      'idTransectOrig': _idTransectOrig,
      'codeEssence': _codeEssence,
      'refTransect': _refTransect,
      'distance': _distance,
      'orientation': _orientation,
      'azimutSouche': _azimutSouche,
      'distanceSouche': _distanceSouche,
      'diametre': _diametre,
      'diametre130': _diametre130,
      'ratioHauteur': _ratioHauteur,
      'contact': _contact,
      'angle': _angle,
      'chablis': _chablis,
      'stadeDurete': _stadeDurete,
      'stadeEcorce': _stadeEcorce,
      'observation': _observation,
    });
    return '';
  }

  @override
  Future<String> updateObject() async {
    _transectListViewModel.updateItem({
      'idTransect': _idTransect,
      'idCyclePlacette': _idCyclePlacette,
      'idTransectOrig': _idTransectOrig,
      'codeEssence': _codeEssence,
      'refTransect': _refTransect,
      'distance': _distance,
      'orientation': _orientation,
      'azimutSouche': _azimutSouche,
      'distanceSouche': _distanceSouche,
      'diametre': _diametre,
      'diametre130': _diametre130,
      'ratioHauteur': _ratioHauteur,
      'contact': _contact,
      'angle': _angle,
      'chablis': _chablis,
      'stadeDurete': _stadeDurete,
      'stadeEcorce': _stadeEcorce,
      'observation': _observation,
    });
    return '';
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      DropdownFieldConfig<String>(
        fieldName: "Transect",
        fieldRequired: true,
        value: _refTransect != null ? _refTransect.toString() : '',
        validator: (value, formData) {
          if (value == '') {
            return 'Le champ transect est nécessaire.';
          }
          return null;
        },
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('11', '11'),
          const MapEntry('12', '12'),
          const MapEntry('21', '21'),
          const MapEntry('22', '22'),
          const MapEntry('31', '31'),
          const MapEntry('32', '32'),
        ],
        onChanged: (value) {
          _refTransect = value;
          // setRefTransect(value!);
        },
      ),

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
            essence.essenceFilterByCodeEssenceOrNom(filter),
        itemAsString: (dynamic e) {
          return e.codeEssence + ' - ' + e.nom;
        },
        onChanged: (dynamic data) =>
            data == null ? '' : setCodeEssence(data.codeEssence),
        validator: (dynamic text, formData) => validateCodeEssence(),
        futureVariable: essenceFuture,
      ),
      // TextFieldConfig(
      //   fieldName: 'Distance',
      //   initialValue: initialDistanceValue(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _distance = double.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),
      // TextFieldConfig(
      //   fieldName: 'Orientation',
      //   initialValue: initialOrientationValue(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _orientation = double.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),
      // TextFieldConfig(
      //   fieldName: 'AzimutSouche',
      //   initialValue: initialAzimutSoucheValue(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _azimutSouche = double.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),
      // TextFieldConfig(
      //   fieldName: 'DistanceSouche',
      //   initialValue: initialDistanceSoucheValue(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _distanceSouche = double.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),

      TextFieldConfig(
        fieldName: 'Diametre',
        fieldRequired: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametre",
        onChanged: (value) => setDiametre(value),
        fieldUnit: 'cm',
        validator: (value, formData) {
          // Vérifier que la valeur n'est pas nulle
          if (value == '') {
            return 'Le champ Diametre est nécessaire.';
          }
          // Vérifier si la valeur est entre 5 et 30 cm
          if (double.parse(value!) < 5 || double.parse(value) > 30) {
            return 'La valeur doit être entre 5 et 30 cm';
          }
          return null;
        },
        initialValue: initialDiametreValue(),
      ),

      // TextFieldConfig(
      //   fieldName: 'Diametre130',
      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
      //   inputFormatters: [
      //     FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      //     DecimalTextInputFormatter(decimalRange: 1),
      //   ],
      //   hintText: "Veuillez entrer le diametre",
      //   onChanged: (value) => setDiametre130(value),
      //   validator: (value, formData) {
      //     // Vérifier si la valeur en grade est entre 0 et 400
      //     // if (int.parse(value!) < 0 || int.parse(value) > 400) {
      //     //   return 'La valeur doit être entre 0 et 400 gr';
      //     // }
      //     return null;
      //   },
      //   initialValue: '',
      // ),

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
      // CheckboxFieldConfig(
      //   fieldName: 'RatioHauteur',
      //   initialValue: initialRatioHauteur(),
      //   onSaved: (value) => _ratioHauteur = value == 'true',
      // ),
      CheckboxFieldConfig(
        fieldName: 'Contact',
        initialValue: initialContact(),
        onSaved: (value) => setContact(value!),
      ),
      TextFieldConfig(
        fieldName: 'Angle',
        fieldUnit: '°',
        fieldInfo:
            "Angle entre l'horizontal et la pièce de bois - voir notice. Min 0°, Max 50°",
        fieldRequired: true,
        initialValue: initialAngleValue(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _angle = double.parse(value),
        hintText: "Veuillez entrer l'angle",
        validator: (value, formData) {
          // Vérifier que la valeur n'est pas nulle
          if (value == '') {
            return 'Le champ Angle est nécessaire.';
          }
          // Vérifier si la valeur en grade est entre 0 et 400
          if (double.parse(value!) < 0 || double.parse(value) > 50) {
            return 'La valeur doit être entre 0 et 50°';
          }
          return null;
        },
      ),
      CheckboxFieldConfig(
        fieldName: 'Chablis',
        initialValue: initialChablis(),
        onSaved: (value) => setChablis(value!),
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
        itemAsString: (dynamic e) {
          return '${e.idNomenclature} - ' + e.labelDefault;
        },
        onChanged: (dynamic data) =>
            data == null ? '' : setStadeDurete(data.idNomenclature),
        validator: (dynamic text, formData) {
          if (text == null) {
            return 'Le champ Stade Durete est nécessaire.';
          }
          return null;
        },
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
        itemAsString: (dynamic e) {
          return '${e.idNomenclature} - ' + e.labelDefault;
        },
        onChanged: (dynamic data) =>
            data == null ? '' : setStadeEcorce(data.idNomenclature),
        validator: (dynamic text, formData) {
          if (text == null) {
            return 'Le champ Stade Ecorce est nécessaire.';
          }
          return null;
        },
      ),
      TextFieldConfig(
        fieldName: 'observation',
        hintText: "Champ libre",
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

  initialDiametre130Value() {}

  bool initialRatioHauteur() => _ratioHauteur ?? false;

  bool initialContact() => _contact ?? false;

  bool initialChablis() => _chablis ?? false;

  int initialStadeDureteValue() => _stadeDurete ?? 0;

  int initialStadeEcorceValue() => _stadeEcorce ?? 0;

  String? validateCodeEssence() {
    if (_codeEssence == '') {
      return 'Le champ code Essence est nécessaire.';
    } else {
      return null;
    }
  }
}
