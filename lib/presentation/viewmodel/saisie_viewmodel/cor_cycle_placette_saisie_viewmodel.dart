import 'dart:ffi';

import 'package:dendro3/data/entity/arbres_entity.dart';
import 'package:dendro3/domain/domain_module.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_id.dart';
import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/essence_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/usecase/get_essences_usecase.dart';
import 'package:dendro3/domain/usecase/create_arbre_and_mesure_usecase.dart';
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/arbre_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/baseList/base_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:dendro3/presentation/state/state.dart';

//TODO: à clean et revoir lorsque ce sera fini

final corCyclePlacetteSaisieViewModelProvider = Provider.autoDispose
    .family<CorCyclePlacetteSaisieViewModel, Map<String, dynamic>>(
        (ref, arbreInfoObj) {
  final corCyclePlacetteListViewModel =
      ref.watch(corCyclePlacetteListViewModelStateNotifierProvider.notifier);
  return CorCyclePlacetteSaisieViewModel(
      ref,
      arbreInfoObj['cycle'],
      arbreInfoObj['placette'],
      arbreInfoObj['corCyclePlacette'],
      corCyclePlacetteListViewModel);
}
        // ref.watch(insertArbreUseCaseProvider))
        );

class CorCyclePlacetteSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final CorCyclePlacetteListViewModel _corCyclePlacetteListViewModel;
  final Ref ref;
  Placette placette;
  Cycle cycle;

  var _idPlacette;

  DateTime? _dateReleve;
  String? _dateIntervention;
  int? _annee;
  String? _natureIntervention;
  String? _gestionPlacette;
  int? _idNomenclatureCastor;
  int? _idNomenclatureFrottis;
  int? _idNomenclatureBoutis;
  double? _recouvHerbesBasses;
  double? _recouvHerbesHautes;
  double? _recouvBuissons;
  double? _recouvArbres;

  bool _isNewCorCyclePlacette = true;

  CorCyclePlacetteSaisieViewModel(
    this.ref,
    this.cycle,
    this.placette,
    final CorCyclePlacette? corCyclePlacette,
    this._corCyclePlacetteListViewModel,
    // this._insertArbreUseCase,
  ) {
    _initCorCyclePlacette(corCyclePlacette);
  }

  _initCorCyclePlacette(final CorCyclePlacette? corCyclePlacette) {
    _idPlacette = placette.idPlacette;
    if (corCyclePlacette == null) {
      _isNewCorCyclePlacette = true;
    } else {
      _dateReleve = corCyclePlacette.dateReleve;
      _dateIntervention = corCyclePlacette.dateIntervention;
      _annee = corCyclePlacette.annee;
      _natureIntervention = corCyclePlacette.natureIntervention;
      _gestionPlacette = corCyclePlacette.gestionPlacette;
      _idNomenclatureCastor = corCyclePlacette.idNomenclatureCastor;
      _idNomenclatureFrottis = corCyclePlacette.idNomenclatureFrottis;
      _idNomenclatureBoutis = corCyclePlacette.idNomenclatureBoutis;
      _recouvHerbesBasses = corCyclePlacette.recouvHerbesBasses;
      _recouvHerbesHautes = corCyclePlacette.recouvHerbesHautes;
      _recouvBuissons = corCyclePlacette.recouvBuissons;
      _recouvArbres = corCyclePlacette.recouvArbres;
    }
  }

  @override
  Future<void> createObject() async {
    _corCyclePlacetteListViewModel.addItem({
      'idPlacette': _idPlacette,
      'dateReleve': _dateReleve,
      'dateIntervention': _dateIntervention,
      'annee': _annee,
      'natureIntervention': _natureIntervention,
      'gestionPlacette': _gestionPlacette,
      'idNomenclatureCastor': _idNomenclatureCastor,
      'idNomenclatureFrottis': _idNomenclatureFrottis,
      'idNomenclatureBoutis': _idNomenclatureBoutis,
      'recouvHerbesBasses': _recouvHerbesBasses,
      'recouvHerbesHautes': _recouvHerbesHautes,
      'recouvBuissons': _recouvBuissons,
      'recouvArbres': _recouvArbres,
    });
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      TextFieldConfig(
          fieldName: "idPlacette",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      DateFieldConfig(
          fieldName: "dateReleve",
          onDateSelected: (DateTime date) {
            _dateReleve = date;
          }),
      TextFieldConfig(
          fieldName: "dateIntervention",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "annee",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "natureIntervention",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "gestionPlacette",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "idNomenclatureCastor",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "idNomenclatureFrottis",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "idNomenclatureBoutis",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "recouvHerbesBasses",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "recouvHerbesHautes",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "recouvBuissons",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
          fieldName: "recouvArbres",
          initialValue: "",
          hintText: 'Veuillez entrer le code'),
    ];
  }
}
