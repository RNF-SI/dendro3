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
      arbreInfoObj['formType'],
      corCyclePlacetteListViewModel);
});

class CorCyclePlacetteSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final CorCyclePlacetteListViewModel _corCyclePlacetteListViewModel;
  final Ref ref;
  Placette placette;
  Cycle cycle;
  CorCyclePlacette? corCyclePlacette;
  final String formType;

  int? _idCycle;
  var _idPlacette;
  late String? _idCyclePlacette;
  DateTime? _dateReleve;
  String? _dateIntervention = '';
  int? _annee;
  String? _natureIntervention = '';
  String? _gestionPlacette = '';
  int? _idNomenclatureCastor;
  int? _idNomenclatureFrottis;
  int? _idNomenclatureBoutis;
  double? _recouvHerbesBasses;
  double? _recouvHerbesHautes;
  double? _recouvBuissons;
  double? _recouvArbres;
  int? _coeff;
  double? _diamLim;

  bool _isNewCorCyclePlacette = true;

  CorCyclePlacetteSaisieViewModel(
    this.ref,
    this.cycle,
    this.placette,
    this.corCyclePlacette,
    this.formType,
    this._corCyclePlacetteListViewModel,
    // this._insertArbreUseCase,
  ) {
    _initCorCyclePlacette(corCyclePlacette);
  }

  _initCorCyclePlacette(final CorCyclePlacette? corCyclePlacette) {
    _idCycle = cycle.idCycle;
    _idPlacette = placette.idPlacette;
    if (formType == 'add') {
      _isNewCorCyclePlacette = true;
      _idCyclePlacette = null;
    } else {
      _idCyclePlacette = corCyclePlacette!.idCyclePlacette;
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
      _coeff = corCyclePlacette.coeff;
      _diamLim = corCyclePlacette.diamLim;
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
      'coeff': _coeff,
      'diamLim': _diamLim,
    });
    return '';
  }

  @override
  Future<String> updateObject() async {
    _corCyclePlacetteListViewModel.updateItem({
      'idCyclePlacette': _idCyclePlacette,
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
      'coeff': _coeff,
      'diamLim': _diamLim,
    });
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
        fieldName: "Date de Releve",
        fieldRequired: true,
        fieldInfo: "Date de relevé de la placette",
        initialValue: intialDateReleve(),
        onDateSelected: (DateTime date) {
          _dateReleve = date;
        },
      ),
      TextFieldConfig(
        fieldName: "Date Intervention",
        fieldInfo: "Date de dernière intervention sylvicole",
        fieldUnit: "année",
        initialValue: initialDateIntervention(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hintText: 'Veuillez entrer le code',
        onChanged: (p0) => _dateIntervention = p0,
      ),
      // TextFieldConfig(
      //   fieldName: "Année",
      //   initialValue: "",
      //   hintText: "Veuillez entrer l'année",
      //   keyboardType: TextInputType.number,
      //   inputFormatters: [
      //     FilteringTextInputFormatter.digitsOnly,
      //     FilteringTextInputFormatter.allow(RegExp(r"[0-9]{0,4}$"))
      //   ],
      //   onChanged: (value) => setAnnee(value),
      // ),
      TextFieldConfig(
        fieldName: "Nature de l'intervention",
        fieldInfo: "Ex: Coupe Rase, Coupe d'éclaircie, ...",
        initialValue: initialNatureIntervention(),
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
            "Géré: Parcelle soumise à exploitation sylvicole; \nNon Gérée: Peuplement en libre évolution garantie sur le long terme",
      ),

      TextFieldConfig(
        fieldName: "Coeff",
        keyboardType: TextInputType.number,
        initialValue: initialCoeff(),
        hintText: "Veuillez entre le coefficient",
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (p0) => _coeff = int.parse(p0),
      ),

      TextFieldConfig(
        fieldName: "Diamètre limite",
        keyboardType: TextInputType.number,
        initialValue: initialDiamLim(),
        hintText: "Veuillez entrer le diamètre limite",
        onChanged: (p0) => _diamLim = double.parse(p0),
      ),
    ];
  }

  setAnnee(String value) {
    _annee = int.parse(value);
  }

  String initialDateIntervention() {
    if (_dateIntervention == '') {
      return '';
    } else {
      return _dateIntervention!;
    }
  }

  initialDiamLim() {
    if (_diamLim == null) {
      return '';
    } else {
      return _diamLim.toString();
    }
  }

  initialCoeff() {
    if (_coeff == null) {
      return '';
    } else {
      return _coeff.toString();
    }
  }

  initialNatureIntervention() {
    if (_natureIntervention == '') {
      return '';
    } else {
      return _natureIntervention!;
    }
  }

  intialDateReleve() {
    if (_dateReleve == null) {
      _dateReleve = DateTime.now();
      return DateTime.now();
    } else {
      return _dateReleve;
    }
  }
}
