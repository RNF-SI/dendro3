import 'dart:ffi';

import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/nomenclature.dart';
import 'package:dendro3/domain/model/nomenclature_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_code_ecolo_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_ecorce_nomenclature_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/view/login_page.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:dendro3/presentation/state/state.dart';

//TODO: à clean et revoir lorsque ce sera fini

final arbreSaisieViewModelProvider = Provider.autoDispose
    .family<ArbreSaisieViewModel, Map<String, dynamic>>((ref, arbreInfoObj) {
  final arbreListViewModel =
      ref.watch(arbreListViewModelStateNotifierProvider.notifier);
  return ArbreSaisieViewModel(
      ref,
      arbreInfoObj['cycle'],
      arbreInfoObj['placette'],
      arbreInfoObj['arbre'],
      arbreInfoObj['arbreMesure'],
      arbreInfoObj['formType'],
      arbreInfoObj['previousCycleCoupe'],
      ref.watch(getEssencesUseCaseProvider),
      ref.watch(getStadeDureteNomenclaturesUseCaseProvider),
      ref.watch(getStadeEcorceNomenclaturesUseCaseProvider),
      ref.watch(getCodeEcoloNomenclaturesUseCaseProvider),
      arbreListViewModel);
});

class ArbreSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final ArbreListViewModel _arbreListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  final GetStadeDureteNomenclaturesUseCase _getStadeDureteNomenclaturesUseCase;
  final GetStadeEcorceNomenclaturesUseCase _getStadeEcorceNomenclaturesUseCase;
  final GetCodeEcoloNomenclaturesUseCase _getCodeEcoloNomenclaturesUseCase;
  // final InsertArbreUseCase _insertArbreUseCase;
  final Ref ref;

  final String formType;

  final String? previousCycleCoupe;
  // late TodoId _id;
  // var _title = '';
  // var _description = '';
  // var _isCompleted = false;
  // var _dueDate = DateTime.now();
  // Essence? _initialEssence = null;
  // Essence? initialEssence = null;

  EssenceList? _essences;
  Future<List<Essence>>? essenceFuture;

  NomenclatureList? _codeEcoloNomenclatures;
  List<Nomenclature>? currentCodeEcoloNomenclature;
  Future<List<Nomenclature>>? codeEcoloFuture;

  NomenclatureList? stadeDureteNomenclatures;
  Future<List<Nomenclature>>? stadeDureteFuture;

  NomenclatureList? stadeEcorceNomenclatures;
  Future<List<Nomenclature>>? stadeEcorceFuture;

  Placette placette;
  Cycle cycle;

  Arbre? arbre;

  late int? _idArbre;
  int? _idArbreOrig;
  var _idPlacette;
  var _codeEssence = '';
  double? _azimut;
  double? _distance;
  bool _taillis = false;
  var _observation = '';

  // late ArbreMesureId idArbreMesure='';
  // var _idArbre = '';
  late int? _idArbreMesure;
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
  var _refCodeEcolo = 'EFI';
  bool _ratioHauteur = false;
  var _observationMesure = '';
  var _isNewArbreMesure = false;

  bool isLoadingEssences = true;

  ArbreSaisieViewModel(
    this.ref,
    this.cycle,
    this.placette,
    this.arbre,
    final ArbreMesure? arbreMesure,
    this.formType,
    this.previousCycleCoupe,
    this._getEssencesUseCase,
    this._getStadeDureteNomenclaturesUseCase,
    this._getStadeEcorceNomenclaturesUseCase,
    this._getCodeEcoloNomenclaturesUseCase,
    this._arbreListViewModel,
    // this._insertArbreUseCase,
  ) {
    // _essences = await _getEssencesUseCase.execute();
    _initArbre(arbre);
    _initArbreMesure(arbreMesure);
    // _getEssences();
    // _getEssences();
    essenceFuture = getAndSetInitialEssence();
    codeEcoloFuture = getCodeEcoloNomenclaturesWithMnemonique(null);
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

  Future<void> getCodeEcoloNomenclatures() async {
    try {
      _codeEcoloNomenclatures =
          await _getCodeEcoloNomenclaturesUseCase.execute();
    } on Exception catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  List<Nomenclature> getCurrentCodeEcoloNomenclatures(formData) {
    // try {
    List<Nomenclature>? listNomenclature;
    if (formData != null && formData.containsKey('Référentiel DMH')) {
      listNomenclature = _codeEcoloNomenclatures!.values
          .toList()
          .where((Nomenclature item) =>
              item.mnemonique!.contains(formData!['Référentiel DMH']))
          .toList();
    } else {
      listNomenclature = _codeEcoloNomenclatures!.values
          .toList()
          .where((Nomenclature item) => item.mnemonique!.contains('EFI'))
          .toList();
    }
    currentCodeEcoloNomenclature = listNomenclature;
    return listNomenclature;
    // return currentCodeEcoloNomenclature!;
    // } on Exception catch (e) {
    //   print(e);
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<List<Nomenclature>> getCodeEcoloNomenclaturesWithMnemonique(
      formData) async {
    if (_codeEcoloNomenclatures == null) {
      await getCodeEcoloNomenclatures();
    }
    return getCurrentCodeEcoloNomenclatures(formData);
    // return currentCodeEcoloNomenclature;
  }

  _initArbre(final Arbre? arbre) {
    _idPlacette = placette.idPlacette;
    if (formType == 'add') {
      _idArbre = null;
    } else if (formType == 'edit') {
      // Init ArbreInfos
      _idArbre = arbre!.idArbre;
      _idArbreOrig = arbre.idArbreOrig;
      _codeEssence = arbre.codeEssence;
      _azimut = arbre.azimut;
      _distance = arbre.distance;
      _taillis = arbre.taillis ?? true;
      _observation = arbre.observation ?? '';
    } else if (formType == 'newMesure') {
      // Init ArbreInfos
      _idArbre = arbre!.idArbre;
      _idArbreOrig = arbre.idArbreOrig;
      _codeEssence = arbre.codeEssence;
      _azimut = arbre.azimut;
      _distance = arbre.distance;
      _taillis = arbre.taillis ?? true;
      _observation = arbre.observation ?? '';
    }
  }

  _initArbreMesure(final ArbreMesure? arbreMesure) {
    _idCycle = cycle.idCycle;
    if (formType == 'add') {
      _isNewArbreMesure = true;
      _idArbreMesure = null;
    } else if (formType == 'edit') {
      // Init ArbreInfos
      _idArbreMesure = arbreMesure!.idArbreMesure;
      _idCycle = arbreMesure.idCycle;
      _diametre1 = arbreMesure.diametre1;
      _diametre2 = arbreMesure.diametre2;
      _type = arbreMesure.type ?? '';
      _hauteurTotale = arbreMesure.hauteurTotale;
      _hauteurBranche = arbreMesure.hauteurBranche;
      _stadeDurete = arbreMesure.stadeDurete;
      _stadeEcorce = arbreMesure.stadeEcorce;
      _liane = arbreMesure.liane ?? '';
      _diametreLiane = arbreMesure.diametreLiane;
      _coupe =
          previousCycleCoupe != null ? previousCycleCoupe!.toUpperCase() : '';
      _limite = arbreMesure.limite ?? false;
      _idNomenclatureCodeSanitaire = arbreMesure.idNomenclatureCodeSanitaire;
      _codeEcolo = arbreMesure.codeEcolo ?? '';
      _refCodeEcolo = arbreMesure.refCodeEcolo ?? 'EFI';
      _ratioHauteur = arbreMesure.ratioHauteur ?? false;
      _observationMesure = arbreMesure.observation ?? '';
    } else if (formType == 'newMesure') {
      // Init ArbreInfos
      _idArbreMesure = null;
      // _idCycle = arbreMesure.idCycle;
      // _diametre1 = arbreMesure.diametre1;
      // _diametre2 = arbreMesure.diametre2;
      // _type = arbreMesure.type ?? '';
      // _hauteurTotale = arbreMesure.hauteurTotale;
      // _hauteurBranche = arbreMesure.hauteurBranche;
      // _stadeDurete = arbreMesure.stadeDurete;
      // _stadeEcorce = arbreMesure.stadeEcorce;
      // _liane = arbreMesure.liane ?? '';
      // _diametreLiane = arbreMesure.diametreLiane;
      // _coupe = arbreMesure.coupe ?? '';
      // _limite = arbreMesure.limite ?? false;
      // _idNomenclatureCodeSanitaire = arbreMesure.idNomenclatureCodeSanitaire;
      // _codeEcolo = arbreMesure.codeEcolo ?? '';
      // _refCodeEcolo = arbreMesure.refCodeEcolo ?? 'EFI';
      // _ratioHauteur = arbreMesure.ratioHauteur ?? false;
      // _observationMesure = arbreMesure.observation ?? '';
    }
  }

  Future<String> createObject() async {
    if (formType == 'add') {
      _arbreListViewModel.addItem({
        'idPlacette': _idPlacette,
        'codeEssence': _codeEssence,
        'azimut': _azimut!,
        'distance': _distance!,
        'taillis': _taillis,
        'observation': _observation,
        'idCycle': _idCycle,
        'numCycle': cycle.numCycle,
        'diametre1': _diametre1,
        'diametre2': _diametre2,
        'type': _type,
        'hauteurTotale': _hauteurTotale,
        'hauteurBranche': _hauteurBranche,
        'stadeDurete': _stadeDurete,
        'stadeEcorce': _stadeEcorce,
        'liane': _liane,
        'diametreLiane': _diametreLiane,
        'coupe': '',
        'limite': _limite,
        'idNomenclatureCodeSanitaire': _idNomenclatureCodeSanitaire,
        'codeEcolo': _codeEcolo,
        'refCodeEcolo': _refCodeEcolo,
        'ratioHauteur': _ratioHauteur,
        'observationMesure': _observationMesure,
      });
    } else {
      _arbreListViewModel.addMesureItem(
        arbre!,
        {
          'idPlacette': _idPlacette,
          'codeEssence': _codeEssence,
          'azimut': _azimut!,
          'distance': _distance!,
          'taillis': _taillis,
          'observation': _observation,
          'idCycle': _idCycle,
          'numCycle': cycle.numCycle,
          'diametre1': _diametre1,
          'diametre2': _diametre2,
          'type': _type,
          'hauteurTotale': _hauteurTotale,
          'hauteurBranche': _hauteurBranche,
          'stadeDurete': _stadeDurete,
          'stadeEcorce': _stadeEcorce,
          'liane': _liane,
          'diametreLiane': _diametreLiane,
          'coupe': _coupe,
          'limite': _limite,
          'idNomenclatureCodeSanitaire': _idNomenclatureCodeSanitaire,
          'codeEcolo': _codeEcolo,
          'refCodeEcolo': _refCodeEcolo,
          'ratioHauteur': _ratioHauteur,
          'observationMesure': _observationMesure,
        },
      );
    }
    return '';
  }

  @override
  Future<String> updateObject() async {
    _arbreListViewModel.updateItem(
      {
        'idArbre': _idArbre,
        'idArbreOrig': _idArbreOrig,
        'idPlacette': _idPlacette,
        'codeEssence': _codeEssence,
        'azimut': _azimut!,
        'distance': _distance!,
        'taillis': _taillis,
        'observation': _observation,
        'idArbreMesure': _idArbreMesure,
        'idCycle': _idCycle,
        'numCycle': cycle.numCycle,
        'diametre1': _diametre1,
        'diametre2': _diametre2,
        'type': _type,
        'hauteurTotale': _hauteurTotale,
        'hauteurBranche': _hauteurBranche,
        'stadeDurete': _stadeDurete,
        'stadeEcorce': _stadeEcorce,
        'liane': _liane,
        'diametreLiane': _diametreLiane,
        'coupe': _coupe,
        'limite': _limite,
        'idNomenclatureCodeSanitaire': _idNomenclatureCodeSanitaire,
        'codeEcolo': _codeEcolo,
        'refCodeEcolo': _refCodeEcolo,
        'ratioHauteur': _ratioHauteur,
        'observationMesure': _observationMesure,
      },
      arbre: arbre,
    );
    return '';
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
  String initialAzimutValue() {
    if (_azimut == null) {
      return '';
    }
    // Check if azimut is a whole number and display it as an integer if so
    return _azimut == _azimut!.toInt()
        ? _azimut!.toInt().toString()
        : _azimut!.toStringAsFixed(1);
  }

  String initialDistanceValue() =>
      _distance != null ? _distance.toString() : '';
  bool initialTaillisValue() => _taillis ?? true;

  int initialStadeDureteValue() => _stadeDurete ?? 0;
  int initialStadeEcorceValue() => _stadeEcorce ?? 0;

  String initialDiametre1Value() {
    if (_diametre1 == null) {
      return '';
    }
    return _diametre1 == _diametre1!.toInt()
        ? _diametre1!.toInt().toString()
        : _diametre1!.toStringAsFixed(1);
  }

  String initialDiametre2Value() {
    if (_diametre2 == null) {
      return '';
    }
    return _diametre2 == _diametre2!.toInt()
        ? _diametre2!.toInt().toString()
        : _diametre2!.toStringAsFixed(1);
  }

  String initialHauteurTotaleValue() {
    if (_hauteurTotale == null) {
      return '';
    }
    return _hauteurTotale == _hauteurTotale!.toInt()
        ? _hauteurTotale!.toInt().toString()
        : _hauteurTotale!.toStringAsFixed(1);
  }

  // String initialDescriptionValue() => _description;

  // DateTime initialDueDateValue() => _dueDate;

  // DateTime datePickerFirstDate() => DateTime(DateTime.now().year - 5, 1, 1);

  // DateTime datePickerLastDate() => DateTime(DateTime.now().year + 5, 12, 31);

  bool initialLimiteValue() => _taillis ?? true;
  bool initialRatioHauteurValue() => _ratioHauteur ?? true;

  setCodeEssence(final String value) => _codeEssence = value;
  // setters Arbre
  setAzimut(final String value) => _azimut = double.parse(value);
  setDistance(final String value) => _distance = double.parse(value);
  setTaillis(final bool value) => _taillis = value;
  setObservation(final String value) => _observation = value;

  // setters ArbreMesure
  setDiametre1(final String? value) {
    _diametre1 = (value != null && value != '') ? double.parse(value!) : null;
  }

  setDiametre2(final String? value) =>
      _diametre2 = (value != null && value != '') ? double.parse(value!) : null;
  setType(final String value) => _type = value;
  setHauteurTotale(final String? value) =>
      _hauteurTotale = value != null ? double.parse(value) : null;
  setHauteurBranche(final String value) =>
      _hauteurBranche = double.parse(value);
  setStadeDurete(final int? value) => _stadeDurete = value;
  setStadeEcorce(final int? value) => _stadeEcorce = value;
  setLiane(final String value) => _liane = value;
  setDiametreLiane(final String value) => _diametreLiane = double.parse(value);
  setCoupe(final String value) => _coupe = value;
  setLimite(final bool value) => _limite = value;
  setIdNomenclatureCodeSanitaire(final int value) =>
      _idNomenclatureCodeSanitaire = value;
  setCodeEcolo(final String value) => _codeEcolo = value;
  setRefCodeEcolo(final String value) {
    _refCodeEcolo = value;
  }

  setRatioHauteur(final bool value) => _ratioHauteur = value;
  setObservationMesure(final String value) => _observationMesure = value;

  String? validateCodeEssence() {
    if (_codeEssence == '') {
      return 'Le champ code Essence est nécessaire.';
    } else
      return null;
  }

  String? validateAzimut() {
    if (_azimut == null) {
      return 'Le champs azimut est nécessaire.';
    } else if (_azimut! < 0 || _azimut! > 400) {
      return 'La valeur doit être entre 0 et 400 gr';
    } else {
      return null;
    }
  }

  String? validateDistance() {
    if (_distance == null) {
      return 'Le champs distance est nécessaire.';
    } else if (_distance! < 0 || _distance! > 100) {
      return 'La valeur doit être entre 0 et 100';
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

//   final arbreFormConfig = [
//   TextFieldConfig(
//     fieldName: 'IdPlacette',
//     initialValue: initialIdPlacetteValue(),
//     isEditable: false,
//     // validator: ...,
//   ),
//   FieldConfig(
//     fieldName: 'Code Essence',
//     initialValue: '', // or whatever the initial value should be
//     isEditable: true,
//     // validator: ...,
//   ),
//   // ... other fields ...
// ];

  @override
  List<FieldConfig> getFormConfig() {
    return [
      // TextFieldConfig(
      //   fieldName: 'IdPlacette',
      //   initialValue: initialIdPlacetteValue(),
      //   isEditable: false,
      //   hintText: 'Entrer le code',
      //   // validator: ...,
      // ),
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
        fieldName: 'Azimut',
        fieldRequired: true,
        fieldUnit: 'gr',
        initialValue: initialAzimutValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (String? text, formData) => validateAzimut(),
        hintText: "Entrer l'azimut",
        onChanged: (value) => setAzimut(value),
      ),

      TextFieldConfig(
        fieldName: 'Distance',
        fieldRequired: true,
        fieldUnit: 'm',
        initialValue: initialDistanceValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        validator: (String? text, formData) => validateDistance(),
        hintText: "Entrer la distance",
        onChanged: (value) => setDistance(value),
      ),
      CheckboxFieldConfig(
        fieldName: 'Taillis',
        initialValue: initialTaillisValue(),
        onSaved: (value) => setTaillis(value!),
      ),

      TextFieldConfig(
        fieldName: 'Diametre1',
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}([.,]\d{0,1})?$')),
        ],
        initialValue: initialDiametre1Value(),
        fieldInfo: 'Diamètre apparent',
        fieldUnit: 'cm',
        fieldRequired: true,
        hintText: "Entrer le diametre1",
        onChanged: (value) {
          setDiametre1(value);
          if (_diametre1 != null && _diametre1! <= 30) {
            setDiametre2(null);
          }
          // setState(() {});
        },
        validator: (value, formData) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer une valeur';
          }
          final double? parsedValue = double.tryParse(value);
          if (parsedValue == null) {
            return 'Veuillez entrer un nombre valide';
          }
          if (parsedValue < 7.5 || parsedValue > 300) {
            return 'Entre 7.5 cm et 300 cm';
          }
          return null;
        },
      ),

      TextFieldConfig(
          fieldName: 'Diametre2',
          initialValue: initialDiametre2Value(),
          fieldRequired: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            DecimalTextInputFormatter(decimalRange: 1),
          ],
          isVisibleFn: (formData) {
            if (formData.isNotEmpty) {
              return (formData['Diametre1'] != null &&
                      formData['Diametre1'] != '' &&
                      int.parse(formData['Diametre1']) > 30) ||
                  (_diametre1 != null && _diametre1! > 30);
            } else {
              return (_diametre1 != null && _diametre1! > 30);
            }
          },
          hintText: "Entrer le diametre2",
          fieldUnit: 'cm',
          fieldInfo:
              'Diamètre perpendiculaire au diamètre1, mesuré uniquement si D1>30cm',
          validator: (value, formData) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer une valeur';
            }
            final double? parsedValue = double.tryParse(value);
            if (parsedValue == null) {
              return 'Veuillez entrer un nombre valide';
            }
            if (parsedValue < 7.5 || parsedValue > 300) {
              return 'Entre 7.5 cm et 300 cm';
            }
            return null;
          },
          onChanged: (value) {
            setDiametre2(value);
          }),
      DropdownFieldConfig<dynamic>(
        fieldName: 'Type',
        value: _type,
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('1', '1- arbre mort sur pied'),
          const MapEntry('2', '2- chandelle'),
          const MapEntry('3', '3- souche'),
          const MapEntry('4', '4- souche anthropique'),
          const MapEntry('5', '5- souche naturelle'),
        ],
        validator: (value, formData) {
          return null;
        },
        onChanged: (value) {
          setType(value);
          if (value == null || value == '') {
            setStadeDurete(null);
            setStadeEcorce(null);
            setHauteurTotale(null);
          }
        },
        fieldInfo:
            "Complété uniquement si l'arbre est mort\n(Plus de branche vivante).\nTypes:\n1 - arbre mort sur pied\n2 - chandelle (plus de branches et hauteurs <1.3m\n3 - souche (plus de branche et hauteur <1.3m\n4 - souche anthropique\n5 - souche naturelle)",
      ),
      // TextFieldConfig(
      //   fieldName: 'type',
      //   initialValue: '',
      //   hintText: "Entrer le type",
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter some text';
      //     }
      //     return null;
      //   },
      //   onChanged: (value) => setType(value),
      // ),

      TextFieldConfig(
        fieldName: 'Hauteur',
        initialValue: initialHauteurTotaleValue(),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        fieldRequired: true,
        isVisibleFn: (formData) {
          if (formData.isNotEmpty) {
            return (formData['Type'] != null && formData['Type'] != '') ||
                (_type != '');
          } else {
            return (_type != '');
          }
        },
        fieldUnit: 'm',
        hintText: "Entrer la hauteur",
        validator: (value, formData) {
          if ((value == null || value.isEmpty)) {
            if (formData['Type'] != null || !formData['Type'].isEmpty) {
              return 'Veuillez entrer une valeur';
            }
            return null;
          }
          final double? parsedValue = double.tryParse(value);
          if (parsedValue! > 60) {
            return 'Valeur supérieure à 60m';
          } else if ((formData['Type'] == '1' || formData['Type'] == '2') &&
              parsedValue < 1.3) {
            return "Le type +$formData['Type'] implique une taille supérieure à 1.3m";
          } else if ((formData['Type'] == '3' ||
                  formData['Type'] == '4' ||
                  formData['Type'] == '5') &&
              parsedValue >= 1.3) {
            return "Le type +$formData['Type'] implique une taille inférieure à 1.3m";
          }
          return null;
        },
        onChanged: (value) => setHauteurTotale(value),
      ),
      // TextFieldConfig(
      //   fieldName: 'HauteurBranche',
      //   initialValue: '',
      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
      //   inputFormatters: [
      //     FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      //     DecimalTextInputFormatter(decimalRange: 1),
      //   ],
      //   hintText: "Entrer la hauteurBranche",
      //   onChanged: (value) => setHauteurBranche(value),
      // ),

      DropdownSearchConfig(
        fieldName: 'Stade Durete',
        fieldRequired: true,
        futureVariable: stadeDureteFuture,
        asyncItems: (String filter, [Map<String, dynamic>? options]) =>
            getStadeDureteNomenclatures(),
        // selectedItem: initialEssence,
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
        isVisibleFn: (formData) {
          if (formData.isNotEmpty) {
            return (formData['Type'] != null && formData['Type'] != '') ||
                (_type != '');
          } else {
            return (_type != '');
          }
        },
        onChanged: (dynamic? data) =>
            data == null ? '' : setStadeDurete(data.idNomenclature),
        validator: (value, formData) {
          if ((value == null || value == '')) {
            if (formData['Type'] != null || !formData['Type'].isEmpty) {
              return 'Veuillez entrer une valeur';
            }
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
        // selectedItem: initialEssence,
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

        isVisibleFn: (formData) {
          if (formData.isNotEmpty) {
            return (formData['Type'] != null && formData['Type'] != '') ||
                (_type != '');
          } else {
            return (_type != '');
          }
        },
        onChanged: (dynamic? data) =>
            data == null ? '' : setStadeEcorce(data.idNomenclature),
        validator: (value, formData) {
          if ((value == null || value == '')) {
            if (formData['Type'] != null || !formData['Type'].isEmpty) {
              return 'Veuillez entrer une valeur';
            }
          }
          return null;
        },
        // validator: (dynamic? text) => validateCodeEssence(),
      ),

      // TextFieldConfig(
      //   fieldName: 'liane',
      //   inputFormatters: [LengthLimitingTextInputFormatter(25)],
      //   hintText: "Entrer la liane (25 char max)",
      //   initialValue: '',
      // ),

      // TextFieldConfig(
      //   fieldName: 'diametreLiane',
      //   initialValue: '',
      //   keyboardType: TextInputType.numberWithOptions(decimal: true),
      //   inputFormatters: [
      //     FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      //     DecimalTextInputFormatter(decimalRange: 1),
      //   ],
      //   hintText: "Entrer le diametreLiane",
      //   onChanged: (value) => setDiametreLiane(value),
      // ),

      DropdownFieldConfig<dynamic>(
        fieldName: 'Coupe',
        value: _coupe,
        fieldInfo:
            "Lorsque l'arbre a été coupé ou est tombé (chablis) au cycle en cours, modifier le champs 'coupe' du cycle précédent",
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('C', 'chablis'),
          const MapEntry('E', 'exploité'),
          const MapEntry('F', 'Aucune coupe'),
        ],
        validator: (value, formData) {
          return null;
        },
        isVisibleFn: (formData) {
          if (formData.isNotEmpty) {
            if (cycle.numCycle == 1) {
              return false;
            } else if (((formData['Type'] != null) &&
                    (formData['Type'] != '')) ||
                (_type != '')) {
              return true;
            } else
              return false;
          } else if (cycle.numCycle == 1) {
            return false;
          } else {
            return true;
          }
        },
        onChanged: (value) => setCoupe(value),
        importantMessage:
            "En cas de coupe, l'information que vous saisirez ci-dessous sera directement renseignée en base de donnée pour le cycle précédent (Cycle numéro ${cycle.numCycle - 1})",
      ),

      // TextFieldConfig(
      //   fieldName: 'Coupe',
      //   initialValue: '',
      //   hintText: "Entrer la coupe",
      //   inputFormatters: [LengthLimitingTextInputFormatter(1)],
      //   onChanged: (value) => setCoupe(value),
      // ),

      CheckboxFieldConfig(
        fieldName: 'limite',
        initialValue: initialLimiteValue(),
        onSaved: (value) => setLimite(value!),
        fieldInfo:
            "Arbre n'ayant pas les caractéristiques pour être échantillonné. Ne sera pas pris en compte dans l'analyse",
      ),

      // TextFieldConfig(
      //   fieldName: 'idNomenclatureCodeSanitaire',
      //   keyboardType: TextInputType.numberWithOptions(decimal: false),
      //   inputFormatters: [
      //     FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
      //   ],
      //   hintText: "Entrer le idNomenclatureCodeSanitaire",
      //   onChanged: (value) => setIdNomenclatureCodeSanitaire(int.parse(value)),
      //   initialValue: '',
      // ),

      DropdownFieldConfig<dynamic>(
        fieldName: 'Référentiel DMH',
        value: _refCodeEcolo != null ? _refCodeEcolo : 'EFI',
        items: [
          const MapEntry('EFI', 'EFI'),
          const MapEntry('engref', 'engref'),
          const MapEntry('prosilva', 'prosilva'),
          const MapEntry('', '')
        ],
        onChanged: (value) {
          if (value != _refCodeEcolo) {
            setCodeEcolo('');
          }
          setRefCodeEcolo(value);
        },
        validator: (value, formData) {
          return null;
        },
      ),

      // TextFieldConfig(
      //   fieldName: 'Dendromicrohabitat',
      //   keyboardType: TextInputType.numberWithOptions(decimal: false),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter some text';
      //     }
      //     return null;
      //   },
      //   onChanged: (value) => setCodeEcolo(value),
      //   hintText: "Entrer les Dendromicrohabitats",
      //   initialValue: '',
      // ),

      DropdownSearchConfig(
        fieldName: 'Dendromicrohabitat',
        isMultiSelection: true,
        futureVariable: codeEcoloFuture,
        asyncItems: (String filter, [Map<String, dynamic>? formData]) =>
            getCodeEcoloNomenclaturesWithMnemonique(formData),

        filterFn: (dynamic codeEcolo, filter) {
          return codeEcolo.codeEcoloFilterByLabelDefault(filter);
        },
        // selectedItems: _codeEcolo != null && _codeEcolo != ''
        //     ? _codeEcolo.split('-').map((s) => int.parse(s)).toList()
        //     : [],

        selectedItems: () {
          if (_codeEcolo != null && _codeEcolo.isNotEmpty) {
            return currentCodeEcoloNomenclature!
                .where((nomenclature) => _codeEcolo
                    .split('-')
                    // .map((s) => int.parse(s))
                    .contains(nomenclature.cdNomenclature))
                .toList();
          }
          return [];
        },
        itemAsString: (dynamic e) => e.labelDefault,
        onChanged: (dynamic? data) => data == null
            ? []
            : setCodeEcolo(data
                .map((item) => item.cdNomenclature.toString())
                .toList()
                .join('-')),
        // validator: (dynamic? text) => validateCodeEssence(),
      ),

      // DropdownFieldConfig<dynamic>(
      //   fieldName: 'Stade Ecorce',
      //   value: _stadeEcorce != null ? _stadeEcorce.toString() : '',
      //   items: [
      //     const MapEntry('', 'Sélectionnez une option'),
      //     const MapEntry('1', '1- Présente sur tout le billon'),
      //     const MapEntry('2', '2- Présente sur plus de 50% de la surface'),
      //     const MapEntry('3', '3- Présente sur moins de 50% de la surface'),
      //     const MapEntry('4', '4- Absente du billon'),
      //   ],
      //   isVisibleFn: (formData) =>
      //       formData['Type'] != null && formData['Type'] != '',
      //   onChanged: (value) => setStadeEcorce(value),
      // ),

      // TextFieldConfig(
      //   fieldName: 'Référentiel DMH',
      //   hintText: "Entrer le Référentiel DMH",
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return 'Please enter some text';
      //     }
      //     return null;
      //   },
      //   onChanged: (value) => setRefCodeEcolo(value),
      //   initialValue: '',
      // ),

      // CheckboxFieldConfig(
      //   fieldName: 'ratioHauteur',
      //   initialValue: initialRatioHauteurValue(),
      //   onSaved: (value) => setRatioHauteur(value!),
      // ),

      TextFieldConfig(
        fieldName: 'observation',
        hintText: "Entrer le observation",
        onChanged: (value) => setObservationMesure(value),
        initialValue: '',
        validator: (value, formData) {
          return null;
        },
      ),
      //       TextFormField(
      //         keyboardType: TextInputType.numberWithOptions(decimal: true),
      //         inputFormatters: [
      //           FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      //           DecimalTextInputFormatter(decimalRange: 1),
      //         ],
      //         decoration: const InputDecoration(
      //           hintText: "Entrer le diametre1",
      //         ),

      //         // The validator receives the text that the user has entered.
      //         validator: (value) {
      //           // Vérifier si la valeur en grade est entre 0 et 400
      //           if (int.parse(value!) < 0 || int.parse(value) > 400) {
      //             return 'La valeur doit être entre 0 et 400 gr';
      //           }
      //           return null;
      //         },
      //         onChanged: (value) => _viewModel.setDiametre1(value),
      //       ),

      // ... other fields ...
    ];
  }
}
