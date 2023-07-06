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
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
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
      arbreListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class ArbreSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

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

  ArbreSaisieViewModel(
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
  String initialObservationValue() => _observation ?? '';

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
      TextFieldConfig(
        fieldName: 'IdPlacette',
        initialValue: initialIdPlacetteValue(),
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

      // TextFieldConfig(
      //   fieldName: 'Azimut',
      //   initialValue: initialAzimutValue(),
      //   keyboardType: TextInputType.number,
      //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      //   validator: (String? text) => validateAzimut(),
      //   hintText: "Veuillez entrer l'azimut",
      // ),
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
        fieldName: 'Distance',
        initialValue: initialDistanceValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        validator: (String? text) => validateDistance(),
        hintText: "Veuillez entrer la distance",
        onChanged: (value) => setDistance(value),
      ),
      CheckboxFieldConfig(
        fieldName: 'Taillis',
        initialValue: initialTaillisValue(),
        onSaved: (value) => setTaillis(value!),
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
        fieldName: 'Diametre1',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametre1",
        onChanged: (value) => setDiametre1(value),
        validator: (value) {
          // Vérifier si la valeur en grade est entre 0 et 400
          if (int.parse(value!) < 0 || int.parse(value) > 400) {
            return 'La valeur doit être entre 0 et 400 gr';
          }
          return null;
        },
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'Diametre2',
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametre2",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setDiametre2(value),
      ),

      TextFieldConfig(
        fieldName: 'type',
        initialValue: '',
        hintText: "Veuillez entrer le type",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setType(value),
      ),

      TextFieldConfig(
        fieldName: 'HauteurTotale',
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer la hauteurTotale",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setHauteurTotale(value),
      ),
      TextFieldConfig(
        fieldName: 'HauteurBranche',
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer la hauteurBranche",
        onChanged: (value) => setHauteurBranche(value),
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
        fieldName: 'liane',
        inputFormatters: [LengthLimitingTextInputFormatter(25)],
        hintText: "Veuillez entrer la liane (25 char max)",
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'diametreLiane',
        initialValue: '',
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        hintText: "Veuillez entrer le diametreLiane",
        onChanged: (value) => setDiametreLiane(value),
      ),

      TextFieldConfig(
        fieldName: 'coupe',
        initialValue: '',
        hintText: "Veuillez entrer la coupe",
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        onChanged: (value) => setCoupe(value),
      ),

      CheckboxFieldConfig(
        fieldName: 'limite',
        initialValue: initialLimiteValue(),
        onSaved: (value) => setLimite(value!),
      ),

      TextFieldConfig(
        fieldName: 'idNomenclatureCodeSanitaire',
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        ],
        hintText: "Veuillez entrer le idNomenclatureCodeSanitaire",
        onChanged: (value) => setIdNomenclatureCodeSanitaire(int.parse(value)),
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'codeEcolo',
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setCodeEcolo(value),
        hintText: "Veuillez entrer le codeEcolo",
        initialValue: '',
      ),

      TextFieldConfig(
        fieldName: 'refCodeEcolo',
        hintText: "Veuillez entrer le refCodeEcolo",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: (value) => setRefCodeEcolo(value),
        initialValue: '',
      ),

      CheckboxFieldConfig(
        fieldName: 'ratioHauteur',
        initialValue: initialRatioHauteurValue(),
        onSaved: (value) => setRatioHauteur(value!),
      ),

      TextFieldConfig(
        fieldName: 'observation',
        hintText: "Veuillez entrer le observation",
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
      //           hintText: "Veuillez entrer le diametre1",
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
