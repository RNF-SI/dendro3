import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/arbreMesure.dart';
import 'package:dendro3/domain/model/arbre_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/essence.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/form_placette_saisie/form_placette_saisie_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
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

// TODO: Clean quand fini

class FormSaisiePlacettePage extends ConsumerStatefulWidget {
  final Placette placette;
  final Arbre? arbre;
  final ArbreMesure? arbreMesure;
  final Cycle? cycle;

  FormSaisiePlacettePage({
    Key? key,
    required this.placette,
    this.arbre,
    this.arbreMesure,
    this.cycle,
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
  late final FormSaisieViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  // final distanceController = TextEditingController();
  // Arbre arbre = Arbre();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _viewModel = ref.read(formSaisieViewModelProvider({
      'cycle': widget.cycle,
      'placette': widget.placette,
      'arbre': widget.arbre,
      'arbreMesure': widget.arbreMesure,
    }));

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
    // final _viewModel = ref.watch(formSaisieViewModelProvider);

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un arbre'),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFormWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final currentState = _formKey.currentState;
                    if (currentState != null && currentState.validate()) {
                      _viewModel.createOrUpdateArbre();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Ajouter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormWidget() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Informations Arbre',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: 'Veuillez entrer le code',
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "Le code n'est pas reconnu";
              //     }
              //     return null;
              //   },
              // ),

              // DropdownButtonFormField(
              //   value: _selectedValue,
              //   hint: Text(
              //     'choose one',
              //   ),
              //   isExpanded: true,
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedValue = value!;
              //     });
              //   },
              //   // onSaved: (value) {
              //   //   setState(() {
              //   //     _selectedValue = value;
              //   //   });
              //   // },
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return "can't empty";
              //     } else {
              //       return null;
              //     }
              //   },
              //   items: listOfValue.map((String val) {
              //     return DropdownMenuItem(
              //       value: val,
              //       child: Text(
              //         val,
              //       ),
              //     );
              //   }).toList(),
              // ),

              // DropdownSearch<String>(
              //   popupProps: PopupProps.menu(
              //     showSearchBox: true,
              //     showSelectedItems: true,
              //     disabledItemFn: (String s) => s.startsWith('I'),
              //   ),
              //   items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
              //   dropdownDecoratorProps: DropDownDecoratorProps(
              //     dropdownSearchDecoration: InputDecoration(
              //       labelText: "Menu mode",
              //       hintText: "country in menu mode",
              //     ),
              //   ),
              //   onChanged: print,
              //   selectedItem: "Brazil",
              // ),
              Text('IdPlacette'),
              TextFormField(
                initialValue: _viewModel.initialIdPlacetteValue(),
                enabled: false,
                // val
                // value: widget.placette.idPlacette.toString(),
                decoration: const InputDecoration(
                  fillColor: Colors.grey,
                  filled: true,
                  hintText: 'Veuillez entrer le code',
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "Le code n'est pas reconnu";
                //   }
                //   return null;
                // },
              ),
              Text('Code Essence'),
              DropdownSearch<Essence>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  // showSelectedItems: true,
                  // disabledItemFn: (String s) => s.startsWith('I'),
                ),
                clearButtonProps: ClearButtonProps(
                  color: Colors.red,
                  icon: Icon(Icons.close),
                ),
                // mode: Mode.MENU,
                // showSearchBox: true,
                filterFn: (essence, filter) =>
                    essence.essenceFilterByCodeEssence(filter),
                // popupProps: PopupProps.bottomSheet(),
                // dropdownDecoratorProps: DropDownDecoratorProps(
                //   dropdownSearchDecoration:
                //       InputDecoration(labelText: "Name"),
                // ),

                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    hintText: 'Veuillez entre le code essence',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),

                selectedItem: _viewModel.initialEssence,
                // selectedItem: _viewModel.initialCodeEssenceValue(),
                // items: _viewModel.getEssences(),
                // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
                asyncItems: (String filter) => _viewModel.getEssences(),
                itemAsString: (Essence e) => e.codeEssence,
                onChanged: (Essence? data) => data == null
                    ? ''
                    : _viewModel.setCodeEssence(data.codeEssence),
              ),

              // DropdownSearch<UserModel>(
              //     filterFn: (user, filter) =>
              //     user.userFilterByCreationDate(filter),
              //     asyncItems: (String filter) => getData(filter),
              //     itemAsString: (UserModel u) => u.userAsStringByName(),
              //     onChanged: (UserModel? data) => print(data),
              //     dropdownDecoratorProps: DropDownDecoratorProps(
              //         dropdownSearchDecoration: InputDecoration(labelText: "Name"),
              //     ),
              // )

              Text('Azimut'),
              TextFormField(
                initialValue: _viewModel.initialAzimutValue(),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer l'azimut",
                ),
                // The validator receives the text that the user has entered.
                validator: (_) => _viewModel.validateAzimut(),
                onChanged: (value) => _viewModel.setAzimut(value),
              ),
              Text('Distance'),
              TextFormField(
                initialValue: _viewModel.initialDistanceValue(),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  DecimalTextInputFormatter(decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer la distance",
                ),
                // The validator receives the text that the user has entered.
                validator: (_) => _viewModel.validateDistance(),
                onChanged: (value) => _viewModel.setDistance(value),
              ),
              Text('Taillis'),
              CheckboxFormField(
                title: Text('Taillis'),
                initialValue: _viewModel.initialTaillisValue(),
                onSaved: (value) {
                  _viewModel.setTaillis(value!);
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: "Veuillez entrer le taillis",
              //   ),
              //   // The validator receives the text that the user has entered.
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              // ),
              Text('Observation'),
              TextFormField(
                initialValue: _viewModel.initialObservationValue(),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (value) => _viewModel.setObservation(value),
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer l'observation",
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                'Information Arbre mesure',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Informations relatives au cycle',
                style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text('diametre1'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  DecimalTextInputFormatter(decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le diametre1",
                ),

                // The validator receives the text that the user has entered.
                validator: (value) {
                  // Vérifier si la valeur en grade est entre 0 et 400
                  if (int.parse(value!) < 0 || int.parse(value) > 400) {
                    return 'La valeur doit être entre 0 et 400 gr';
                  }
                  return null;
                },
                onChanged: (value) => _viewModel.setDiametre1(value),
              ),

              Text('diametre2'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  DecimalTextInputFormatter(decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le diametre2",
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) => _viewModel.setDiametre2(value),
              ),
              Text('type'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le type",
                ),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
                onChanged: (value) => _viewModel.setType(value),
              ),
              Text('hauteurTotale'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  DecimalTextInputFormatter(decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer la hauteurTotale",
                ),
                onChanged: (value) => _viewModel.setHauteurTotale(value),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              ),
              Text('hauteurBranche'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  DecimalTextInputFormatter(decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer la hauteurBranche",
                ),
                onChanged: (value) => _viewModel.setHauteurBranche(value),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              ),
              Text('stadeDurete'),
              // GestureDetector(
              //   child: InputDecorator(
              //     child: Text(stadeD.toString()),
              //     decoration: InputDecoration(labelText: 'Test'),
              //   ),
              //   onTap: () {
              //     _showIntegerDialogStadeDurete();
              //   },
              // ),
              // NumberPicker(
              //   value: _currentValue,
              //   minValue: 0,
              //   maxValue: 100,
              //   onChanged: (value) => setState(() => _currentValue = value),
              // ),
              // TextFormField(
              //   keyboardType: TextInputType.numberWithOptions(decimal: false),
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r"[1-9]")),
              //     LengthLimitingTextInputFormatter(1),
              //     // DecimalTextInputFormatter(de, decimalRange: 1),
              //   ],
              //   decoration: const InputDecoration(
              //     hintText:
              //         "Veuillez entrer le stadeDurete (valeur entre 1 et 5)",
              //   ),
              //   // The validator receives the text that the user has entered.
              //   validator: (value) {
              //     if (![1, 2, 3, 4, 5].contains(value) || value != null) {
              //       return 'La valeur doit être entre 1 et 5';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) => _viewModel.setStadeDurete(value),
              // ),

              DropdownButtonFormField(
                value: _selectedValue,
                hint: Text(
                  'choose one',
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                    _viewModel.setStadeDurete(int.parse(value));
                  });
                },
                // onSaved: (value) {
                //   setState(() {
                //     _selectedValue = value;
                //   });
                // },
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "can't empty";
                //   } else {
                //     return null;
                //   }
                // },
                items: ['', '1', '2', '3', '4', '5'].map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),

              Text('stadeEcorce'),
              // TextFormField(
              //   keyboardType: TextInputType.numberWithOptions(decimal: false),
              //   inputFormatters: [
              //     FilteringTextInputFormatter.allow(RegExp(r"[1-9]")),
              //     LengthLimitingTextInputFormatter(1),
              //     // DecimalTextInputFormatter(de, decimalRange: 1),
              //   ],
              //   decoration: const InputDecoration(
              //     hintText:
              //         "Veuillez entrer le stadeEcorce (valeur entre 1 et 4)",
              //   ),
              //   // The validator receives the text that the user has entered.
              //   validator: (value) {
              //     if (![1, 2, 3, 4].contains(value) || value != null) {
              //       return 'La valeur doit être entre 1 et 4';
              //     }
              //     return null;
              //   },
              // ),

              DropdownButtonFormField(
                value: _selectedValue,
                hint: Text(
                  'choose one',
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value!;
                    _viewModel.setStadeEcorce(int.parse(value));
                  });
                },
                // onSaved: (value) {
                //   setState(() {
                //     _selectedValue = value;
                //   });
                // },
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return "can't empty";
                //   } else {
                //     return null;
                //   }
                // },
                items: ['', '1', '2', '3', '4'].map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),

              Text('liane'),
              TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(25),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer la liane (25 char max)",
                ),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              ),
              Text('diametreLiane'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  DecimalTextInputFormatter(decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le diametreLiane",
                ),
                onChanged: (value) => _viewModel.setDiametreLiane(value),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              ),
              Text('coupe'),
              TextFormField(
                inputFormatters: [
                  // FilteringTextInputFormatter.allow(RegExp(r"[1-9]")),
                  LengthLimitingTextInputFormatter(1),
                  // DecimalTextInputFormatter(de, decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer la coupe",
                ),
                onChanged: (value) => _viewModel.setCoupe(value),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              ),
              Text('limite'),
              CheckboxFormField(
                title: Text('Limites'),

                // decoration: const InputDecoration(
                //   hintText: "Veuillez entrer le taillis",
                // ),
                // The validator receives the text that the user has entered.
                onSaved: (value) {
                  _viewModel.setLimite(value!);
                  // if (value == null) {
                  //   return 'Please enter some text';
                  // }
                  // return null;
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: "Veuillez entrer le limite",
              //   ),
              //   // The validator receives the text that the user has entered.
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              // ),
              Text('idNomenclatureCodeSanitaire'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[1-9]")),
                  // DecimalTextInputFormatter(de, decimalRange: 1),
                ],
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le idNomenclatureCodeSanitaire",
                ),
                onChanged: (value) =>
                    _viewModel.setIdNomenclatureCodeSanitaire(int.parse(value)),
                // The validator receives the text that the user has entered.
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter some text';
                //   }
                //   return null;
                // },
              ),
              Text('codeEcolo'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le codeEcolo",
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) => _viewModel.setCodeEcolo(value),
              ),
              Text('refCodeEcolo'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le refCodeEcolo",
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) => _viewModel.setRefCodeEcolo(value),
              ),
              Text('ratioHauteur'),
              CheckboxFormField(
                title: Text('ratioHauteur'),

                // decoration: const InputDecoration(
                //   hintText: "Veuillez entrer le taillis",
                // ),
                // The validator receives the text that the user has entered.
                onSaved: (value) {
                  _viewModel.setRatioHauteur(value!);
                  // if (value == null) {
                  //   return 'Please enter some text';
                  // }
                  // return null;
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     hintText: "Veuillez entrer le ratioHauteur",
              //   ),
              //   // The validator receives the text that the user has entered.
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              // ),
              Text('observation'),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Veuillez entrer le observation",
                ),
                onChanged: (value) => _viewModel.setObservation(value),
                // The valida
              ),
            ],
          ),
        ),
      ),
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

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
