import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/lib/form_config/custom_text_input/decimal_text_input_formatter.dart';
import 'package:dendro3/presentation/lib/form_config/field_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placetteSaisieViewModelProvider = Provider.autoDispose
    .family<PlacetteSaisieViewModel, Map<String, dynamic>>((ref, arbreInfoObj) {
  final placetteViewModel =
      ref.watch(placetteViewModelStateNotifierProvider.notifier);
  return PlacetteSaisieViewModel(
    ref,
    arbreInfoObj['placette'],
    placetteViewModel,
  );
});

class PlacetteSaisieViewModel extends ObjectSaisieViewModel {
  // late final ListViewModel _baseListViewModel;

  late final PlacetteViewModel _placetteViewModel;
  final Ref ref;
  Placette placette;

  var _idPlacette;

  int? _exposition;
  double? _pente;

  // bool _isNewPlacette = true;

  PlacetteSaisieViewModel(
    this.ref,
    this.placette,
    this._placetteViewModel,
    // this._insertArbreUseCase,
  ) {
    _initPlacette(placette);
  }

  _initPlacette(final Placette? placette) {
    if (placette == null) {
      _idPlacette = null;
    } else {
      _idPlacette = placette!.idPlacette;
      _pente = placette.pente;
      _exposition = placette.exposition;
    }
  }

  @override
  Future<String> createObject() async {
    _placetteViewModel.addItem({
      'idPlacette': _idPlacette,
      'exposition': _exposition,
      'pente': _pente,
    });
    return '';
  }

  @override
  Future<String> updateObject() async {
    _placetteViewModel.updateItem({
      'idPlacette': _idPlacette,
      'exposition': _exposition,
      'pente': _pente,
    });
    return '';
  }

  String initialPenteValue() => _pente != null ? _pente.toString() : '';

  String? validatePente() {
    if (_pente == null) {
      return 'Le champs pente est nécessaire.';
    } else if (_pente! < 0 || _pente! > 100) {
      return 'La valeur doit être entre 0 et 100';
    } else {
      return null;
    }
  }

  setPente(final String value) => _pente = double.parse(value);

  @override
  List<FieldConfig> getFormConfig() {
    return [
      // TextFieldConfig(
      // fieldName: "idPlacette",
      // initialValue: "",
      // hintText: 'Veuillez entrer le code'),
      TextFieldConfig(
        fieldName: 'Pente',
        fieldRequired: true,
        fieldUnit: '%',
        initialValue: initialPenteValue(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
          DecimalTextInputFormatter(decimalRange: 1),
        ],
        validator: (String? text, formData) => validatePente(),
        hintText: "Entrer la pente",
        onChanged: (value) => setPente(value),
      ),
      TextFieldConfig(
        fieldName: 'Exposition',
        fieldRequired: true,
        initialValue: _exposition != null ? _exposition.toString() : '',
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
        ],
        validator: (String? text, formData) {
          if (text == null || text.isEmpty) {
            return 'Le champs exposition est nécessaire.';
          } else {
            return null;
          }
        },
        hintText: "Entrer l'exposition",
        onChanged: (value) => _exposition = int.parse(value),
      ),
    ];
  }
}
