import 'dart:ffi';

import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  int? _idCycle;
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
    _idCycle = cycle.idCycle;
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
  Future<String> createObject() async {
    _corCyclePlacetteListViewModel.addItem({
      'idCycle': _idCycle,
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
    return '';
  }

  Future<String> updateObject() async {
    return '';
  }

  @override
  List<FieldConfig> getFormConfig() {
    return [
      // TextFieldConfig(
      // fieldName: "idPlacette",
      // initialValue: "",
      // hintText: 'Veuillez entrer le code'),
      DateFieldConfig(
        fieldName: "dateReleve",
        onDateSelected: (DateTime date) {
          _dateReleve = date;
        },
      ),
      TextFieldConfig(
        fieldName: "dateIntervention",
        initialValue: "",
        hintText: 'Veuillez entrer le code',
        onChanged: (p0) => _dateIntervention = p0,
      ),
      TextFieldConfig(
        fieldName: "annee",
        initialValue: "",
        hintText: "Veuillez entrer l'année",
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.allow(RegExp(r"[0-9]{0,4}$"))
        ],
        onChanged: (value) => setAnnee(value),
      ),
      TextFieldConfig(
        fieldName: "natureIntervention",
        initialValue: "",
        hintText: 'Veuillez entrer le code',
        onChanged: (p0) => _natureIntervention = p0,
      ),

      DropdownFieldConfig<dynamic>(
        fieldName: 'gestionPlacette',
        value: _gestionPlacette != null ? _gestionPlacette.toString() : '',
        items: [
          const MapEntry('', 'Sélectionnez une option'),
          const MapEntry('gérée', 'Gérée'),
          const MapEntry('Non gérée', 'Non gérée'),
        ],
        validator: (value, formData) {
          return null;
        },
        onChanged: (value) {
          _gestionPlacette = value;
        },
        fieldInfo:
            "Complété uniquement si l'arbre est mort\n(Plus de branche vivante).\nTypes:\n1 - arbre\n2 - chandelle (plus de branches et hauteurs <1.3m\n3 - souche (plus de branche et hauteur <1.3m\n4 - souche anthropique\n5 - souche naturelle)",
      ),

      // TextFieldConfig(
      //     fieldName: "idNomenclatureCastor",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code',

      //     ),
      // TextFieldConfig(
      //     fieldName: "idNomenclatureFrottis",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code'),
      // TextFieldConfig(
      //     fieldName: "idNomenclatureBoutis",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code'),
      // TextFieldConfig(
      //     fieldName: "recouvHerbesBasses",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code'),
      // TextFieldConfig(
      //     fieldName: "recouvHerbesHautes",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code'),
      // TextFieldConfig(
      //     fieldName: "recouvBuissons",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code'),
      // TextFieldConfig(
      //     fieldName: "recouvArbres",
      //     initialValue: "",
      //     hintText: 'Veuillez entrer le code'),
    ];
  }

  setAnnee(String value) {
    _annee = int.parse(value);
  }
}
