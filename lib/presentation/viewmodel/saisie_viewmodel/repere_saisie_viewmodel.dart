import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/repere_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//TODO: à clean et revoir lorsque ce sera fini

final repereSaisieViewModelProvider = Provider.autoDispose
    .family<RepereSaisieViewModel, Map<String, dynamic>>((ref, regeInfoObj) {
  final repereListViewModel =
      ref.watch(repereListViewModelStateNotifierProvider.notifier);
  return RepereSaisieViewModel(
      ref,
      // regeInfoObj['cycle'],
      // regeInfoObj['placette'],
      regeInfoObj['repere'],
      regeInfoObj['formType'],
      regeInfoObj['corCyclePlacette'],

      // ref.watch(getEssencesUseCaseProvider),
      repereListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class RepereSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final RepereListViewModel _repereListViewModel;

  final String formType;

  CorCyclePlacette? corCyclePlacette;

  final Ref ref;
  // Placette placette;
  // Cycle cycle;

  String? _idRepere;
  int? _idPlacette;
  double? _azimut;
  double? _distance;
  double? _diametre;
  String? _repere;
  String? _observation;
  var _isNewRepere = false;

  RepereSaisieViewModel(
    this.ref,
    // this.cycle,
    // this.placette,
    final Repere? repere,
    this.formType,
    this.corCyclePlacette,
    // this._getEssencesUseCase,
    this._repereListViewModel,
    // this._insertArbreUseCase,
  ) {
    // _getEssences();

    _initRepere(repere);
  }

  _initRepere(final Repere? repere) {
    // _idPlacette = placette.idPlacette;
    if (formType == 'add') {
      _isNewRepere = true;
    } else {
      _idRepere = repere!.idRepere;
      _idPlacette = repere.idPlacette;
      _azimut = repere.azimut;
      _distance = repere.distance;
      _diametre = repere.diametre;
      _repere = repere.repere;
      _observation = repere.observation;
    }
  }

  @override
  Future<String> createObject() async {
    _repereListViewModel.addItem({
      'idPlacette': corCyclePlacette!.idPlacette,
      'azimut': _azimut,
      'distance': _distance,
      'diametre': _diametre,
      'repere': _repere,
      'observation': _observation,
    });
    return '';
  }

  @override
  Future<String> updateObject() async {
    _repereListViewModel.updateItem({
      'idRepere': _idRepere,
      'idPlacette': corCyclePlacette!.idPlacette,
      'azimut': _azimut,
      'distance': _distance,
      'diametre': _diametre,
      'repere': _repere,
      'observation': _observation,
    });
    return '';
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      TextFieldConfig(
        fieldName: 'Azimut',
        initialValue: initialAzimut(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _azimut = double.parse(value),
        hintText: "Veuillez entrer le code",
      ),
      TextFieldConfig(
        fieldName: 'Distance',
        initialValue: initialDistance(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _distance = double.parse(value),
        hintText: "Veuillez entrer le code",
      ),
      TextFieldConfig(
        fieldName: 'Diametre',
        initialValue: initialDiametre(),
        keyboardType: TextInputType.number,
        onChanged: (value) => _diametre = double.parse(value),
        hintText: "Veuillez entrer le code",
      ),
      TextFieldConfig(
        fieldName: 'Repere',
        initialValue: initialRepere(),
        onChanged: (value) => _repere = value,
        hintText: "Veuillez entrer le code",
      ),
      TextFieldConfig(
        fieldName: 'Observation',
        initialValue: initialObservation(),
        onChanged: (value) => _observation = value,
        hintText: "Champs Libre",
      ),
    ];
  }

  // fonction d'Initialisation
  String initialAzimut() => _azimut != null ? _azimut.toString() : '';
  String initialDistance() => _distance != null ? _distance.toString() : '';
  String initialDiametre() => _diametre != null ? _diametre.toString() : '';
  String initialRepere() => _repere ?? '';
  String initialObservation() => _observation ?? '';

  // Fonction setters
}
