import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/domain/model/saisisable_object.dart';
import 'package:dendro3/presentation/lib/form_config/checkbox_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/date_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_field_config.dart';
import 'package:dendro3/presentation/lib/form_config/dropdown_search_config.dart';
import 'package:dendro3/presentation/lib/form_config/text_field_config.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/saisie_viewmodel/arbre_saisie_viewmodel.dart';
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
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un $widget.type'),
      ),
      body: Padding(
        // height: 100,
        padding:
            const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
        // child: SingleChildScrollView(
        child: ListView(
          children: [
            _buildFormWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
          ],
        ),
        // ),
      ),
    );
  }

  Widget _buildFormWidget() {
    var formFields = _viewModel.getFormConfig().map<Widget>((field) {
      if (field is TextFieldConfig) {
        return TextFormField(
          initialValue: field.initialValue,
          enabled: field.isEditable,
          validator: field.validator,
          onChanged: field.onChanged,
          inputFormatters: field.inputFormatters,
          decoration: InputDecoration(
            fillColor: Colors.grey,
            filled: true,
            hintText: field.hintText,
          ),
        );
      } else if (field is DropdownSearchConfig) {
        // Text('Code Essence'),
        return DropdownSearch<dynamic>(
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
              hintText: 'Veuillez entre le code essence',
              hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          selectedItem: field.selectedItem,
          asyncItems: field.asyncItems,
          itemAsString: field.itemAsString,
          onChanged: field.onChanged,
        );

        // return DropdownSearch<Essence> or whatever the widget should be
      } else if (field is DropdownFieldConfig) {
        return DropdownButtonFormField(
          value: field.value,
          hint: Text(
            'choose one',
          ),
          isExpanded: true,
          onChanged: field.onChanged,
          items: field.items.map((String val) {
            return DropdownMenuItem(
              value: val,
              child: Text(
                val,
              ),
            );
          }).toList(),
        );
      } else if (field is CheckboxFieldConfig) {
        return CheckboxFormField(
          title: Text(field.fieldName),
          initialValue: field.initialValue,
          onSaved: field.onSaved,
        );
        // return CheckboxFormField or whatever the widget should be
      } else if (field is DateFieldConfig) {
        return DateTimeFormField(
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
    case 'arbre':
      return ref.read(arbreSaisieViewModelProvider({
        'cycle': widget.cycle,
        'placette': widget.placette,
        'arbre': widget.saisisableObject1,
        'arbreMesure': widget.saisisableObject2,
      }));
    // return ArbreViewModel();
    case 'bms':
    // return BmsViewModel();
    // ...other types
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
