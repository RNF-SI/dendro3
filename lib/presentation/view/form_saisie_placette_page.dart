import 'dart:io';

import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/arbre_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/bmSup30_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/placette_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/transect_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/regeneration_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/repere_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/cor_cycle_placette_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:numberpicker/numberpickerdialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:date_field/date_field.dart';

// TODO: Clean quand fini

class FormSaisiePlacettePage extends ConsumerStatefulWidget {
  final String type;
  final Placette placette;
  final SaisisableObject? saisisableObject1;
  final SaisisableObject? saisisableObject2;
  final Cycle? cycle;
  final CorCyclePlacette? corCyclePlacette;
  final String formType;
  final String? nextCycleType;
  final bool? hasNextMeasurements;

  const FormSaisiePlacettePage({
    Key? key,
    required this.formType,
    required this.type,
    required this.placette,
    this.saisisableObject1,
    this.saisisableObject2,
    required this.cycle,
    required this.corCyclePlacette,
    this.nextCycleType,
    this.hasNextMeasurements,
    // required this.placette,
    // required this.dispCycleList,
  }) : super(key: key);

  // Placette placette;
  // CycleList dispCycleList;

  @override
  FormSaisiePlacettePageState createState() => FormSaisiePlacettePageState();
}

class FormSaisiePlacettePageState
    extends ConsumerState<FormSaisiePlacettePage> {
  // List<String> list = ["Régénération et Transect", "Arbre", "BMS"];
  // final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
  //     textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  late final ObjectSaisieViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();
  // List<dynamic> Function() _selectedDropdownItems;
  List<dynamic>? _selectedDropdownItems = [];
  // final distanceController = TextEditingController();
  // Arbre arbre = Arbre();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _viewModel = getViewModel(ref, widget.type, widget);
    _errorMessage = null;
  }

  late final String _selectedValue = '1';
  List<String> listOfValue = ['1', '2', '3', '4', '5'];

  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formType == 'edit'
            ? 'Modifier un ${widget.type}'
            : widget.formType == 'newMesure'
                ? 'Nouveau cycle pour ${widget.type}'
                : 'Ajouter un ${widget.type}'),
      ),
      body: Padding(
        // height: 100,
        padding:
            const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
        // child: SingleChildScrollView(
        child: ListView(
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Color(0xFF8B5500)),
                ),
              ),
            _buildFormWidget(),
          ],
        ),
        // ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF598979), // Bleu
            foregroundColor: const Color(0xFFF4F1E4), // Beige
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            final currentState = _formKey.currentState;
            if (currentState != null && currentState.validate()) {
              String? tempErrorMessage;
              if (widget.formType == 'edit') {
                tempErrorMessage = await _viewModel.updateObject();
              } else {
                tempErrorMessage = await _viewModel.createObject();
              }

              setState(() {
                _errorMessage = tempErrorMessage;
              });

              if (_errorMessage == null || _errorMessage!.isEmpty) {
                Navigator.pop(context);
              }
            }
          },
          child: widget.formType == 'edit'
              ? const Text('Modifier')
              : const Text('Ajouter'),
        ),
      ),
    );
  }

  Widget _buildFormWidget() {
    late Widget formWidget;
    var formFields = _viewModel.getFormConfig().map<Widget>((field) {
      if (field is TextFieldConfig) {
        formWidget = TextFormField(
          initialValue: field.initialValue,
          enabled: field.isEditable,
          validator: (value) => field.validator(value, formData),
          onChanged: (value) {
            setState(() {
              formData[field.fieldName] = value;
              if (field.fieldName == 'Diametre1') {
                if (value != Null && value != '' && double.parse(value) <= 30) {
                  formData['Diametre2'] = Null;
                }
              }
              field.onChanged!(value);
            });
          },
          inputFormatters: field.inputFormatters,
          keyboardType: field.keyboardType,
          decoration: InputDecoration(
            fillColor: Color(0xFFF4F1E4), // Beige color for the fill
            filled: true,
            hintText: field.hintText,
            suffixText: field.fieldUnit,
            errorStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF8B5500),
            ), // Marron for errors
            errorMaxLines: 3,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF598979)), // Bleu
            ),
          ),
        );
      } else if (field is DropdownSearchConfig && !field.isMultiSelection) {
        formWidget = FutureBuilder<List<dynamic>>(
            future: field.futureVariable ?? Future.value([]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error loading essences",
                    style:
                        TextStyle(color: Color(0xFF8B5500))); // Error in Marron
              } else {
                return DropdownSearch<dynamic>(
                  popupProps: PopupProps.menu(showSearchBox: true),
                  clearButtonProps: ClearButtonProps(
                    color: Color(0xFF1a1a18), // Noir for clear button
                    icon: Icon(Icons.close),
                  ),
                  filterFn: field.filterFn,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      hintText: 'Veuillez entrer le code essence',
                      hintStyle: TextStyle(
                        color: Color(0xFF7DAB9C),
                        fontSize: 12,
                      ), // Light blue
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF598979)), // Bleu
                      ),
                    ),
                  ),
                  selectedItem: field.selectedItem!(),
                  asyncItems: field.asyncItems,
                  itemAsString: field.itemAsString,
                  onChanged: (value) {
                    setState(() {
                      formData[field.fieldName] = value;
                      field.onChanged!(value);
                    });
                  },
                  validator: (value) {
                    return field.validator(value, formData);
                  },
                );
              }
            });
      } else if (field is DropdownSearchConfig && field.isMultiSelection) {
        formWidget = FutureBuilder<List<dynamic>>(
            future: field.futureVariable ?? Future.value([]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Erreur de chargement des essences",
                    style:
                        TextStyle(color: Color(0xFF8B5500))); // Error in Marron
              } else {
                _selectedDropdownItems = field.selectedItems!();
                return DropdownSearch<dynamic>.multiSelection(
                    // key: ValueKey(_selectedDropdownItems!.length),
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: true,
                    ),
                    clearButtonProps: const ClearButtonProps(
                      color: Color.fromARGB(255, 104, 47, 43),
                      icon: Icon(Icons.close),
                    ),
                    filterFn: field.filterFn,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: 'Veuillez entrer le code essence',
                        hintStyle: TextStyle(
                            color: Color(0xFF7DAB9C),
                            fontSize: 12), // Light blue
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF598979)), // Bleu
                        ),
                      ),
                    ),
                    selectedItems: field
                        .selectedItems!(), // Use selectedItems for multiple selections
                    asyncItems: (String filter) =>
                        field.asyncItems(filter, formData),
                    itemAsString: field.itemAsString,
                    onChanged: (List<dynamic> values) {
                      setState(() {
                        formData[field.fieldName] =
                            values; // Ensure formData can store a list
                        field.onChanged!(values);
                      });
                    },
                    validator: (value) {
                      return field.validator(value, formData);
                    });
              }
            });
      } else if (field is DropdownFieldConfig) {
        formWidget = DropdownButtonFormField(
          value: field.value,
          hint: const Text(
            'Sélectionner un élément',
          ),
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              if (field.fieldName == 'Référentiel DMH') {
                if (formData[field.fieldName] != value) {
                  _selectedDropdownItems = [];
                  formData['Dendromicrohabitat'] = [];
                }
              }
              formData[field.fieldName] = value;
              if (field.fieldName == 'Type') {
                if (value == null || value == '') {
                  formData['Hauteur'] = Null;
                  formData['Stade Durete'] = Null;
                  formData['Stade Ecorce'] = Null;
                }
              }
              if (value is String) {
                field.onChanged(value.toString());
              }
            });
          },
          validator: (value) {
            return field.validator!(value, formData);
          },
          items: field.items.map((MapEntry<String, String> entry) {
            return DropdownMenuItem(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
          decoration: InputDecoration(
            hintText: 'Veuillez entrer le code essence',
            hintStyle:
                TextStyle(color: Color(0xFF7DAB9C), fontSize: 12), // Light blue
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF598979)), // Bleu
            ),
          ),
        );
      } else if (field is CheckboxFieldConfig) {
        formWidget = CheckboxFormField(
          title: Text(field.fieldName),
          initialValue: field.initialValue,
          onSaved: (aaa) {
            field.onSaved(aaa);
          },
          onChanged: (aaa) {
            field.onSaved(aaa);
          },
        );
        // return CheckboxFormField or whatever the widget should be
      } else if (field is DateFieldConfig) {
        formWidget = DateTimeFormField(
          initialValue: field.initialValue,
          decoration: InputDecoration(
            hintStyle:
                TextStyle(color: Color(0xFF7DAB9C)), // Light Blue for hint
            errorStyle:
                TextStyle(color: Color(0xFF8B5500)), // Marron for errors
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.event_note),
            labelText: 'Select a date',
          ),
          mode: DateTimeFieldPickerMode.date,
          autovalidateMode: AutovalidateMode.always,
          validator: (e) => null,
          onDateSelected: field.onDateSelected,
        );
      } else {
        throw UnimplementedError('Unknown field type: ${field.runtimeType}');
      }
      return Visibility(
        visible:
            field.isVisibleFn != null ? field.isVisibleFn!(formData) : true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display important message if available
            if (field.importantMessage != null &&
                field.importantMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  field.importantMessage!,
                  style: TextStyle(
                    fontSize: 12, // Slightly larger font for visibility
                    color:
                        Color(0xFF8B5500), // Use Marron for important messages
                  ),
                ),
              ),

            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        field.fieldName.length > 18
                            ? '${field.fieldName.substring(0, 18)}...'
                            : field.fieldName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              10, // Reduced font size from 12 to 10 for the main text
                          color: Color(
                              0xFF1a1a18), // Noir for text for better readability
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (field.fieldUnit != '')
                        Text(
                          ' (${field.fieldUnit})',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(
                                0xFF598979), // Bleu for units to differentiate
                            fontSize:
                                8, // Reduced font size from 10 to 8 for the unit text
                          ),
                        ),
                      if (field.fieldRequired)
                        Text(
                          '*',
                          style: TextStyle(
                            color:
                                Color(0xFF8B5500), // Marron for required fields
                            fontSize:
                                10, // Keeping this size consistent for visibility
                          ),
                        ),
                      if (field.fieldInfo != '')
                        IconButton(
                          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                          constraints: const BoxConstraints(),
                          icon: const Icon(
                            Icons.info_outline,
                            color:
                                Color(0xFF7DAB9C), // Light blue for info icons
                            size: 10, // Reduced icon size from 11 to 10
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Information'),
                                  content: Text(field.fieldInfo),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Color(
                                                0xFFC0C000)), // Vert for button text
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child:
                      formWidget, // This widget will be styled as per previous recommendations
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();

    return Form(
      key: _formKey,
      child: Column(children: formFields),
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    Widget? title,
    required FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool>? validator,
    bool initialValue = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    ValueChanged<bool?>? onChanged,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value ?? false,
                onChanged: (bool? newValue) {
                  if (onChanged != null) {
                    onChanged(newValue); // Call onChanged callback
                  }
                  state.didChange(newValue);
                },
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText ?? '',
                          style: TextStyle(
                            color: Color(0xFF8B5500), // Marron for error text
                            backgroundColor:
                                Color(0xFFF4F1E4), // Beige for contrast
                          ),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color(0xFF598979), // Bleu from your color palette
                checkColor: Color(0xFFF4F1E4), // Beige for the check mark
              );
            });
}

ObjectSaisieViewModel getViewModel(
  ref,
  String type,
  widget,
) {
  switch (type) {
    case 'Arbres':
      return ref.read(arbreSaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'arbre': widget.saisisableObject1,
        'arbreMesure': widget.saisisableObject2,
        'formType': widget.formType,
        'nextCycleType': widget.nextCycleType,
        'hasNextMeasurements': widget.hasNextMeasurements ?? false,
      }));
    // return ArbreViewModel();
    case 'BmsSup30':
      return ref.read(bmsup30SaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'bmsup30': widget.saisisableObject1,
        'bmsup30Mesure': widget.saisisableObject2,
        'formType': widget.formType,
      }));
    // return BmsViewModel();
    // ...other types
    case 'Transects':
      return ref.read(transectSaisieViewModelProvider({
        'corCyclePlacette': widget.corCyclePlacette,
        'transect': widget.saisisableObject1,
        'formType': widget.formType,
      }));
    case 'Regenerations':
      return ref.read(regenerationSaisieViewModelProvider({
        'corCyclePlacette': widget.corCyclePlacette,
        'regeneration': widget.saisisableObject1,
        'formType': widget.formType,
      }));
    case 'Reperes':
      return ref.read(repereSaisieViewModelProvider({
        'corCyclePlacette': widget.corCyclePlacette,
        'repere': widget.saisisableObject1,
        'formType': widget.formType,
      }));
    case 'corCyclePlacette':
      return ref.read(corCyclePlacetteSaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'corCyclePlacette': widget.corCyclePlacette,
        'formType': widget.formType,
      }));
    case 'Placette':
      return ref.read(placetteSaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'formType': widget.formType,
      }));
    default:
      throw Exception('Invalid type: $type');
  }
}
