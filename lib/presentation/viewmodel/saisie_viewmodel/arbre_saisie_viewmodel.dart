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
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/domain/usecase/get_stade_durete_nomenclature_usecase.dart';
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
      ref.watch(getEssencesUseCaseProvider),
      ref.watch(getStadeDureteNomenclaturesUseCaseProvider),
      arbreListViewModel);
});

class ArbreSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final ArbreListViewModel _arbreListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  final GetStadeDureteNomenclaturesUseCase _getStadeDureteNomenclaturesUseCase;
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

  bool isDiametre2Visible = false;

  ArbreSaisieViewModel(
    this.ref,
    this.cycle,
    this.placette,
    final Arbre? arbre,
    final ArbreMesure? arbreMesure,
    this._getEssencesUseCase,
    this._getStadeDureteNomenclaturesUseCase,
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

  Future<List<Nomenclature>> getStadeDureteNomenclatures() async {
    try {
      var nomenclatures = await _getStadeDureteNomenclaturesUseCase.execute();
      return nomenclatures.values.toList();
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

  Future<void> createObject() async {
    if (_isNewArbre) {
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

  int initialStadeDureteValue() => _stadeDurete ?? 0;
  int initialStadeEcorceValue() => _stadeEcorce ?? 0;

  // String initialDescriptionValue() => _description;

  // DateTime initialDueDateValue() => _dueDate;

  // DateTime datePickerFirstDate() => DateTime(DateTime.now().year - 5, 1, 1);

  // DateTime datePickerLastDate() => DateTime(DateTime.now().year + 5, 12, 31);

  bool initialLimiteValue() => _taillis ?? true;
  bool initialRatioHauteurValue() => _ratioHauteur ?? true;

  bool shouldShowDeleteTodoIcon() => !_isNewArbre;

  setCodeEssence(final String value) => _codeEssence = value;
  // setters Arbre
  setAzimut(final String value) => _azimut = double.parse(value);
  setDistance(final String value) => _distance = double.parse(value);
  setTaillis(final bool value) => _taillis = value;
  setObservation(final String value) => _observation = value;

  // setters ArbreMesure
  setDiametre1(final String value) {
    _diametre1 = double.parse(value);
    if (_diametre1! > 30) {
      isDiametre2Visible = true;
    } else {
      isDiametre2Visible = false;
    }
  }

  setDiametre2(final String value) => _diametre2 = double.parse(value);
  setType(final String value) => _type = value;
  setHauteurTotale(final String value) => _hauteurTotale = double.parse(value);
  setHauteurBranche(final String value) =>
      _hauteurBranche = double.parse(value);
  setStadeDurete(final int value) => _stadeDurete = value;
  setStadeEcorce(final String value) => _stadeEcorce = int.parse(value);
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
        asyncItems: (String filter) => getEssences(),
        selectedItem: initialEssence,
        filterFn: (dynamic essence, filter) =>
            essence.essenceFilterByCodeEssence(filter),
        itemAsString: (dynamic e) => e.codeEssence,
        onChanged: (dynamic? data) =>
            data == null ? '' : setCodeEssence(data.codeEssence),
        validator: (dynamic? text) => validateCodeEssence(),
      ),
      TextFieldConfig(
        fieldName: 'Azimut',
        fieldRequired: true,
        fieldUnit: 'gr',
        initialValue: initialAzimutValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (String? text) => validateAzimut(),
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
        validator: (String? text) => validateDistance(),
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
        fieldInfo: 'Diamètre apparent',
        fieldUnit: 'cm',
        fieldRequired: true,
        hintText: "Entrer le diametre1",
        onChanged: (value) {
          setDiametre1(value);
          // setState(() {});
        },
        validator: (value) {
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
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'Diametre2',
        initialValue: '',
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        isVisibleFn: (formData) =>
            formData['Diametre1'] != null &&
            double.tryParse(formData['Diametre1']) != null &&
            double.tryParse(formData['Diametre1'])! > 30,
        hintText: "Entrer le diametre2",
        fieldUnit: 'cm',
        fieldInfo:
            'Diamètre perpendiculaire au diamètre1, mesuré uniquement si D1>30cm',
        validator: (value) {
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
        onChanged: (value) => setDiametre2(value),
      ),
      DropdownFieldConfig<dynamic>(
        fieldName: 'Type',
        value: _type,
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('1', '1- arbre'),
          const MapEntry('2', '2- chandelle'),
          const MapEntry('3', '3- souche'),
          const MapEntry('4', '4- souche anthropique'),
          const MapEntry('5', '5- souche naturelle'),
        ],
        onChanged: (value) => setType(value),
        fieldInfo:
            "Complété uniquement si l'arbre est mort\n(Plus de branche vivante).\nTypes:\n1 - arbre\n2 - chandelle (plus de branches et hauteurs <1.3m\n3 - souche (plus de branche et hauteur <1.3m\n4 - souche anthropique\n5 - souche naturelle)",
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
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        fieldUnit: 'm',
        hintText: "Entrer la hauteur",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          final double? parsedValue = double.tryParse(value);
          if (parsedValue! > 60) {
            return 'Valeur supérieure à 60m';
          } else if ((_type == '1' || _type == '2') && parsedValue < 1.3) {
            return 'Le type +$_type implique une taille supérieure à 1.3m';
          } else if ((_type == '3' || _type == '4' || _type == '5') &&
              parsedValue >= 1.3) {}
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
        asyncItems: (String filter) => getStadeDureteNomenclatures(),
        // selectedItem: initialEssence,
        filterFn: (dynamic essence, filter) {
          return true;
        },
        itemAsString: (dynamic e) => e.labelDefault,
        isVisibleFn: (formData) =>
            formData['Type'] != null && formData['Type'] != '',
        onChanged: (dynamic? data) =>
            data == null ? '' : setStadeDurete(data.idNomenclature),
        // validator: (dynamic? text) => validateCodeEssence(),
      ),

      DropdownFieldConfig<dynamic>(
        fieldName: 'Stade Ecorce',
        value: _stadeEcorce != null ? _stadeEcorce.toString() : '',
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('1', '1- Présente sur tout le billon'),
          const MapEntry('2', '2- Présente sur plus de 50% de la surface'),
          const MapEntry('3', '3- Présente sur moins de 50% de la surface'),
          const MapEntry('4', '4- Absente du billon'),
        ],
        isVisibleFn: (formData) =>
            formData['Type'] != null && formData['Type'] != '',
        onChanged: (value) => setStadeEcorce(value),
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
        ],
        isVisibleFn: (formData) =>
            (formData['Type'] != null) &&
            (formData['Type'] != '') &&
            (cycle.numCycle != 1),
        onChanged: (value) => setCoupe(value),
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

      TextFieldConfig(
        fieldName: 'Dendromicrohabitat',
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setCodeEcolo(value),
        hintText: "Entrer les Dendromicrohabitats",
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'Référentiel DMH',
        hintText: "Entrer le Référentiel DMH",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setRefCodeEcolo(value),
        initialValue: '',
      ),

      // CheckboxFieldConfig(
      //   fieldName: 'ratioHauteur',
      //   initialValue: initialRatioHauteurValue(),
      //   onSaved: (value) => setRatioHauteur(value!),
      // ),

      TextFieldConfig(
        fieldName: 'observation',
        hintText: "Entrer le observation",
        onChanged: (value) => setObservation(value),
        initialValue: '',
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
