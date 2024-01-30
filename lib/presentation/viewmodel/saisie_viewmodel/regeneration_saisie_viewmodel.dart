
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/regeneration_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
//TODO: à clean et revoir lorsque ce sera fini

final regenerationSaisieViewModelProvider = Provider.autoDispose
    .family<RegenerationSaisieViewModel, Map<String, dynamic>>(
        (ref, regeInfoObj) {
  final regenerationListViewModel =
      ref.watch(regenerationListViewModelStateNotifierProvider.notifier);
  return RegenerationSaisieViewModel(
      ref,
      // regeInfoObj['cycle'],
      // regeInfoObj['placette'],
      regeInfoObj['regeneration'],
      regeInfoObj['formType'],
      regeInfoObj['corCyclePlacette'],
      ref.watch(getEssencesUseCaseProvider),
      regenerationListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class RegenerationSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final RegenerationListViewModel _regenerationListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;

  final Ref ref;
  // Placette placette;
  // Cycle cycle;
  final String formType;

  EssenceList? _essences;
  Future<List<Essence>>? essenceFuture;

  CorCyclePlacette? corCyclePlacette;

  late String? _idRegeneration;
  String? _idCyclePlacette;
  int? _sousPlacette;
  var _codeEssence = '';
  double? _recouvrement;
  int? _classe1 = 0;
  int? _classe2 = 0;
  int? _classe3 = 0;
  bool _taillis = false;
  bool _abroutissement = false;
  int? _idNomenclatureAbroutissement;
  var _observation;
  var _isNewRegeneration = false;
  // bool _isNewRegeneration = true;

  RegenerationSaisieViewModel(
    this.ref,
    // this.cycle,
    // this.placette,
    final Regeneration? regeneration,
    this.formType,
    this.corCyclePlacette,
    this._getEssencesUseCase,
    this._regenerationListViewModel,
    // this._insertArbreUseCase,
  ) {
    _initRegeneration(regeneration);

    essenceFuture = getAndSetInitialEssence();
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

  _initRegeneration(final Regeneration? regeneration) {
    // _idPlacette = placette.idPlacette;
    if (formType == 'add') {
      _isNewRegeneration = true;
      _idRegeneration = null;
    } else {
      _idRegeneration = regeneration!.idRegeneration;
      _idCyclePlacette = regeneration.idCyclePlacette;
      _sousPlacette = regeneration.sousPlacette;
      _codeEssence = regeneration.codeEssence;
      _recouvrement = regeneration.recouvrement;
      _classe1 = regeneration.classe1;
      _classe2 = regeneration.classe2;
      _classe3 = regeneration.classe3;
      _taillis = regeneration.taillis;
      _abroutissement = regeneration.abroutissement;
      _idNomenclatureAbroutissement = regeneration.idNomenclatureAbroutissement;
      _observation = regeneration.observation;
    }
  }

  String? validateCodeEssence() {
    if (_codeEssence == '') {
      return 'Le champ code Essence est nécessaire.';
    } else {
      return null;
    }
  }

  @override
  Future<String> createObject() async {
    if (isUniqueCombination()) {
      _regenerationListViewModel.addItem({
        'idCyclePlacette': corCyclePlacette!.idCyclePlacette,
        'sousPlacette': _sousPlacette,
        'codeEssence': _codeEssence,
        'recouvrement': _recouvrement,
        'classe1': _classe1,
        'classe2': _classe2,
        'classe3': _classe3,
        'taillis': _taillis,
        'abroutissement': _abroutissement,
        'idNomenclatureAbroutissement': _idNomenclatureAbroutissement,
        'observation': _observation,
      });
      return '';
    } else {
      return 'La combinaison Sous placette, Essence et Taillis existe déjà';
    }
  }

  @override
  Future<String> updateObject() async {
    if (isUniqueCombination()) {
      _regenerationListViewModel.updateItem({
        'idRegeneration': _idRegeneration,
        'idCyclePlacette': _idCyclePlacette,
        'sousPlacette': _sousPlacette,
        'codeEssence': _codeEssence,
        'recouvrement': _recouvrement,
        'classe1': _classe1,
        'classe2': _classe2,
        'classe3': _classe3,
        'taillis': _taillis,
        'abroutissement': _abroutissement,
        'idNomenclatureAbroutissement': _idNomenclatureAbroutissement,
        'observation': _observation,
      });
    } else {
      return 'La combinaison Sous placette, Essence et Taillis existe déjà';
    }
    return '';
  }

  bool isUniqueCombination() {
    return corCyclePlacette!.regenerations!
        .isUniqueCombination(_sousPlacette, _codeEssence, _taillis);
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      DropdownFieldConfig<dynamic>(
        fieldName: 'Sous placette',
        fieldRequired: true,
        value: _sousPlacette != null ? _sousPlacette.toString() : '',
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('1', '1'),
          const MapEntry('2', '2'),
          const MapEntry('3', '3'),
        ],
        validator: (value, formData) {
          return null;
        },
        onChanged: (value) {
          _sousPlacette = int.parse(value);
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
            essence.essenceFilterByCodeEssence(filter),
        itemAsString: (dynamic e) => e.codeEssence,
        onChanged: (dynamic data) =>
            data == null ? '' : setCodeEssence(data.codeEssence),
        validator: (dynamic text, formData) => validateCodeEssence(),
        futureVariable: essenceFuture,
      ),
      TextFieldConfig(
        fieldName: 'Recouvrement',
        fieldInfo: "Hauteur < 50 cm en surface de recouvrement",
        fieldUnit: '%',
        fieldRequired: true,
        initialValue: initialRecouvrement(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _recouvrement = double.parse(value),
        hintText: 'Veuillez entrer le pourcentage de recouvrement',
      ),
      TextFieldConfig(
        fieldName: 'Classe 1',
        fieldInfo: "Nombre de tiges 50cm< H < 1.5m",
        initialValue: _classe1.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        fieldRequired: true,
        hintText: "Entrer le le nombre de tiges",
        onChanged: (value) => _classe1 = int.parse(value),
      ),
      TextFieldConfig(
        fieldName: 'Classe 2',
        fieldInfo: "Nombre de tiges H > 1.5m et diamètre <2.5cm",
        initialValue: _classe2.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        fieldRequired: true,
        hintText: "Entrer nombre de tiges",
        onChanged: (value) => _classe2 = int.parse(value),
      ),
      TextFieldConfig(
        fieldName: 'Classe 3',
        fieldInfo: "Nombre de tiges 2.5cm< diamètre < 7.5cm",
        initialValue: _classe3.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        fieldRequired: true,
        hintText: "Entrer le nombre de tiges",
        onChanged: (value) => _classe3 = int.parse(value),
      ),
      CheckboxFieldConfig(
        fieldName: 'Taillis',
        initialValue: initialTaillis(),
        onSaved: (value) => setTaillis(value!),
      ),
      CheckboxFieldConfig(
        fieldName: 'Abroutissement',
        initialValue: initialAbroutissement(),
        onSaved: (value) => setAbroutissement(value!),
      ),
      // TextFieldConfig(
      //   fieldName: 'Id nomenclature abroutissement',
      //   initialValue: initialIdNomenclatureAbroutissement().toString(),
      //   keyboardType: TextInputType.number,
      //   onChanged: (value) => _idNomenclatureAbroutissement = int.parse(value),
      //   hintText: 'Veuillez entrer le code',
      // ),
      TextFieldConfig(
        fieldName: 'Observation',
        initialValue: initialObservation(),
        onChanged: (value) => _observation = value,
        hintText: 'Champ Libre',
      ),
    ];
  }

  // fonction d'Initialisation
  int initialSousPlacette() => _sousPlacette ?? 0;
  int initialClasse1() => _classe1 ?? 0;
  int initialClasse2() => _classe2 ?? 0;
  int initialClasse3() => _classe3 ?? 0;
  bool initialTaillis() => _taillis ?? false;
  bool initialAbroutissement() => _abroutissement ?? false;
  int initialIdNomenclatureAbroutissement() =>
      _idNomenclatureAbroutissement ?? 0;
  String initialObservation() => _observation ?? '';
  String initialRecouvrement() {
    if (_recouvrement == null) {
      return '';
    }
    return _recouvrement == _recouvrement!.toInt()
        ? _recouvrement!.toInt().toString()
        : _recouvrement!.toStringAsFixed(1);
  }

  // Fonction setters
  setCodeEssence(final String value) => _codeEssence = value;
  setRecouvrement(final double value) => _recouvrement = value;
  setClasse1(final int value) => _classe1 = value;
  setClasse2(final int value) => _classe2 = value;
  setClasse3(final int value) => _classe3 = value;
  setTaillis(final bool value) {
    _taillis = value;
  }

  setAbroutissement(final bool value) {
    _abroutissement = value;
  }

  setIdNomenclatureAbroutissement(final int value) =>
      _idNomenclatureAbroutissement = value;
  setObservation(final String value) => _observation = value;
}
