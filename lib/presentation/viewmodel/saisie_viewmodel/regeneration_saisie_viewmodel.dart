import 'dart:ffi';

import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/regeneration_list_viewmodel.dart';
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
      ref.watch(getEssencesUseCaseProvider),
      regenerationListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class RegenerationSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final RegenerationListViewModel _regenerationListViewModel;
  final GetEssencesUseCase _getEssencesUseCase;
  late EssenceList _essences;
  Essence? _initialEssence = null;
  Essence? initialEssence = null;

  final Ref ref;
  // Placette placette;
  // Cycle cycle;

  int? _idCyclePlacette;
  int? _sousPlacette;
  var _codeEssence;
  double? _recouvrement;
  int? _classe1;
  int? _classe2;
  int? _classe3;
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
    this._getEssencesUseCase,
    this._regenerationListViewModel,
    // this._insertArbreUseCase,
  ) {
    _getEssences();

    _initRegeneration(regeneration);
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

  _initRegeneration(final Regeneration? regeneration) {
    // _idPlacette = placette.idPlacette;
    if (regeneration == null) {
      _isNewRegeneration = true;
    } else {
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

  @override
  Future<void> createObject() async {
    if (_isNewRegeneration) {
      _regenerationListViewModel.addItem({
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
      //   _regenerationListViewModel.updateItem({
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
  Future<void> updateObject() async {}

  @override
  List<FieldConfig> getFormConfig() {
    return [
      TextFieldConfig(
        fieldName: 'Sous placette',
        initialValue: _sousPlacette.toString(),
        onChanged: (value) => _sousPlacette = int.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      DropdownSearchConfig(
        fieldName: 'Code Essence',
        asyncItems: (String filter, [Map<String, dynamic>? options]) =>
            getEssences(),
        selectedItem: () {
          return _essences.values
              .where((element) => element.codeEssence == _codeEssence)
              .first;
        },
        filterFn: (dynamic essence, filter) =>
            essence.essenceFilterByCodeEssence(filter),
        itemAsString: (dynamic e) => e.codeEssence,
        onChanged: (dynamic? data) =>
            data == null ? '' : setCodeEssence(data.codeEssence),
      ),
      TextFieldConfig(
        fieldName: 'Recouvrement',
        initialValue: initialRecouvrement(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _recouvrement = double.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      DropdownFieldConfig<dynamic>(
        fieldName: 'Classe ',
        value: _classe1,
        items: [
          const MapEntry('', ''),
          const MapEntry('1', '1'),
        ],
        onChanged: (value) => setClasse1(initialClasse1()),
      ),
      DropdownFieldConfig<dynamic>(
        fieldName: 'Classe 2',
        value: _classe2,
        items: [
          const MapEntry('0', '0'),
          const MapEntry('1', '1'),
        ],
        onChanged: (value) => setClasse2(initialClasse2()),
      ),
      DropdownFieldConfig<dynamic>(
        fieldName: 'Classe 3',
        value: _classe1,
        items: [
          const MapEntry('', ''),
          const MapEntry('3', '3'),
        ],
        onChanged: (value) => setClasse1(initialClasse3()),
      ),
      CheckboxFieldConfig(
        fieldName: 'Taillis',
        initialValue: initialTaillis(),
        onSaved: (value) => _taillis = value == 'true',
      ),
      CheckboxFieldConfig(
        fieldName: 'Abroutissement',
        initialValue: initialAbroutissement(),
        onSaved: (value) => _taillis = value == 'true',
      ),
      TextFieldConfig(
        fieldName: 'Id nomenclature abroutissement',
        initialValue: initialIdNomenclatureAbroutissement().toString(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _idNomenclatureAbroutissement = int.parse(value),
        hintText: 'Veuillez entrer le code',
      ),
      TextFieldConfig(
        fieldName: 'Observation',
        initialValue: initialObservation(),
        onChanged: (value) => _observation = value,
        hintText: 'Veuillez entrer le code',
      ),
    ];
  }

  // fonction d'Initialisation
  int initialSousPlacette() => _sousPlacette ?? 0;
  String initialRecouvrement() =>
      _recouvrement != null ? _recouvrement.toString() : '';
  int initialClasse1() => _classe1 ?? 0;
  int initialClasse2() => _classe2 ?? 0;
  int initialClasse3() => _classe3 ?? 0;
  bool initialTaillis() => _taillis ?? false;
  bool initialAbroutissement() => _abroutissement ?? false;
  int initialIdNomenclatureAbroutissement() =>
      _idNomenclatureAbroutissement ?? 0;
  String initialObservation() => _observation ?? '';

  // Fonction setters
  setCodeEssence(final String value) => _codeEssence = value;
  setRecouvrement(final double value) => _recouvrement = value;
  setClasse1(final int value) => _classe1 = value;
  setClasse2(final int value) => _classe2 = value;
  setClasse3(final int value) => _classe3 = value;
  setTaillis(final bool value) => _taillis = value;
  setAbroutissement(final bool value) => _abroutissement = value;
  setIdNomenclatureAbroutissement(final int value) =>
      _idNomenclatureAbroutissement = value;
  setObservation(final String value) => _observation = value;
}
