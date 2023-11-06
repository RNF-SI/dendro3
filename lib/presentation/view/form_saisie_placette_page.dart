import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/arbre_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/bmSup30_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/transect_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/regeneration_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/repere_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/cor_cycle_placette_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/object_saisie_viewmodel.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;
import 'package:data_table_2/data_table_2.dart';
import 'package:numberpicker/numberpicker.dart';
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

  FormSaisiePlacettePage({
    Key? key,
    required this.type,
    required this.placette,
    this.saisisableObject1,
    this.saisisableObject2,
    required this.cycle,
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
  List<dynamic> _selectedDropdownItems = [];
  // final distanceController = TextEditingController();
  // Arbre arbre = Arbre();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = getViewModel(ref, widget.type, widget);

    // distanceController.addListener(() {
    //   updateDistanceWarning();
    // })
  }

  int stadeD = 2;
  // void updateDistanceWarning() {
  //   if(distanceController.value!=null &&){
  late String _selectedValue = '1';
  List<String> listOfValue = ['1', '2', '3', '4', '5'];

  Map<String, dynamic> formData = {};
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un ${widget.type}'),
      ),
      body: Padding(
        // height: 100,
        padding:
            const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
        // child: SingleChildScrollView(
        child: ListView(
          children: [
            _buildFormWidget(),
          ],
        ),
        // ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () {
            final currentState = _formKey.currentState;
            if (currentState != null && currentState.validate()) {
              _viewModel.createObject();
              Navigator.pop(context);
            }
          },
          child: const Text('Ajouter'),
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
          validator: (value) {
            return field.validator!(value, formData);
          },
          onChanged: (value) {
            setState(() {
              formData[field.fieldName] = value;
              if (field.fieldName == 'Diametre1') {
                if (value != Null &&
                    value != '' &&
                    double.parse(value!) <= 30) {
                  formData['Diametre2'] = Null;
                }
              }
              field.onChanged!(value);
            });
          },
          inputFormatters: field.inputFormatters,
          keyboardType: field.keyboardType,
          decoration: InputDecoration(
            fillColor: Colors.grey,
            filled: true,
            hintText: field.hintText,
            suffixText: field.fieldUnit,
          ),
        );
      } else if (field is DropdownSearchConfig && !field.isMultiSelection) {
        // Text('Code Essence'),
        formWidget = DropdownSearch<dynamic>(
          popupProps: PopupProps.menu(
            showSearchBox: true,
          ),
          clearButtonProps: ClearButtonProps(
            color: Colors.red,
            icon: Icon(Icons.close),
          ),
          filterFn: field.filterFn,
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              disabledBorder: InputBorder.none,
              hintText: 'Veuillez entrer le code essence',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          selectedItem: field.selectedItem,
          asyncItems: field.asyncItems,
          itemAsString: field.itemAsString,
          onChanged: (value) {
            setState(() {
              formData[field.fieldName] = value;
              field.onChanged!(value);
            });
          },
          validator: (value) {
            return field.validator!(value, formData);
          },
        );

        // return DropdownSearch<Essence> or whatever the widget should be
      } else if (field is DropdownSearchConfig && field.isMultiSelection) {
        _selectedDropdownItems = field.selectedItems!;
        formWidget = DropdownSearch<dynamic>.multiSelection(
            key: ValueKey(_selectedDropdownItems.length),
            popupProps: PopupPropsMultiSelection.menu(
              showSearchBox: true,
            ),
            clearButtonProps: ClearButtonProps(
              color: Colors.red,
              icon: Icon(Icons.close),
            ),
            filterFn: field.filterFn,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                disabledBorder: InputBorder.none,
                hintText: 'Veuillez entrer le code essence',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            selectedItems:
                _selectedDropdownItems, // Use selectedItems for multiple selections
            asyncItems: (String filter) => field.asyncItems(filter, formData),
            itemAsString: field.itemAsString,
            onChanged: (List<dynamic> values) {
              setState(() {
                formData[field.fieldName] =
                    values; // Ensure formData can store a list
                field.onChanged!(values);
              });
            },
            validator: (value) {
              return field.validator!(value, formData);
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
              field.onChanged!(value);
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
        );
      } else if (field is CheckboxFieldConfig) {
        formWidget = CheckboxFormField(
          title: Text(field.fieldName),
          initialValue: field.initialValue,
          onSaved: field.onSaved,
        );
        // return CheckboxFormField or whatever the widget should be
      } else if (field is DateFieldConfig) {
        formWidget = DateTimeFormField(
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.black45),
            errorStyle: TextStyle(color: Colors.redAccent),
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.event_note),
            labelText: 'Only time',
          ),
          mode: DateTimeFieldPickerMode.time,
          autovalidateMode: AutovalidateMode.always,
          validator: (e) =>
              (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
          onDateSelected: field.onDateSelected,
        );
      } else {
        throw UnimplementedError('Unknown field type: ${field.runtimeType}');
      }
      return Visibility(
        visible:
            field.isVisibleFn != null ? field.isVisibleFn!(formData) : true,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    field.fieldName.length > 18
                        ? '${field.fieldName.substring(0, 18)}...'
                        : field.fieldName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    overflow:
                        TextOverflow.ellipsis, // Ajouter la propriété overflow
                  ),
                  if (field.fieldUnit != '')
                    Text(
                      ' ( ${field.fieldUnit})',
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  if (field.fieldRequired)
                    const Text(
                      '*',
                      style: TextStyle(color: Colors.red),
                    ),
                  if (field.fieldInfo != '')
                    IconButton(
                      padding: EdgeInsets.only(left: 0.0, right: 0.0),
                      icon: const Icon(
                        Icons.info_outline,
                        color: Colors.grey,
                        size: 12,
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
                                  child: Text('OK'),
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
              flex: 3,
              child: formWidget,
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

  // Future _showIntegerDialogStadeDurete() async {
  //   await showDialog<int>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return new NumberPickerDialog.integer(
  //         minValue: 1,
  //         maxValue: 5,
  //         step: 1,
  //         initialIntegerValue: _currentCurrentStadeDValue,
  //         title: new Text("Sélectionner un stade de dureté"),
  //       );
  //     },
  //   ).then(_handleValueChangedExternally);
  // }

  // Future _showIntegerDialogStadeDurete() async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Select Weight', textAlign: TextAlign.center),
  //         content: StatefulBuilder(builder: (context, setState) {
  //           return Container(
  //             height: 350,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 NumberPicker(
  //                   step: 1,
  //                   itemCount: 5,
  //                   minValue: 1,
  //                   maxValue: 5,
  //                   value: stadeD,
  //                   onChanged: (value) => setState(() {
  //                     stadeD = value;
  //                   }),
  //                 ),
  //                 ElevatedButton(
  //                   child: Text('Approve'),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                 ),
  //               ],
  //             ),
  //           );
  //         }),
  //       );
  //     },
  //   );
  // }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget? title,
      FormFieldSetter<bool>? onSaved,
      FormFieldValidator<bool>? validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText!,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}

ObjectSaisieViewModel getViewModel(ref, String type, widget) {
  switch (type) {
    case 'Arbres':
      return ref.read(arbreSaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'arbre': widget.saisisableObject1,
        'arbreMesure': widget.saisisableObject2,
      }));
    // return ArbreViewModel();
    case 'BmsSup30':
      return ref.read(bmsup30SaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'bms': widget.saisisableObject1,
        'bmsMesure': widget.saisisableObject2,
      }));
    // return BmsViewModel();
    // ...other types
    case 'Transects':
      return ref.read(transectSaisieViewModelProvider({
        'transects': widget.saisisableObject1,
      }));
    case 'Regenerations':
      return ref.read(regenerationSaisieViewModelProvider({
        'regenerations': widget.saisisableObject1,
      }));
    case 'Repères':
      return ref.read(repereSaisieViewModelProvider({
        'reperes': widget.saisisableObject1,
      }));
    case 'corCyclePlacette':
      return ref.read(corCyclePlacetteSaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'corCyclePlacette': widget.saisisableObject1,
      }));
    default:
      throw Exception('Invalid type: $type');
  }
}
