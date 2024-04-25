import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/lib/utils.dart';
import 'package:dendro3/presentation/view/form_saisie_placette_page.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacetteCycleWidget extends ConsumerStatefulWidget {
  const PlacetteCycleWidget({
    Key? key,
    required this.placette,
    required this.corCyclePlacetteList,
    required this.dispCycleList,
  }) : super(key: key);

  final Placette placette;
  final CorCyclePlacetteList corCyclePlacetteList;
  final CycleList? dispCycleList;

  @override
  PlacetteCycleWidgetState createState() => PlacetteCycleWidgetState();
}

class AppColors {
  static const Color blue1 = Color(0xFF598979);
  static const Color green = Color(0xFF8AAC3E);
  static const Color blue2 = Color(0xFF7DAB9C);
  static const Color black = Color(0xFF1a1a18);
  static const Color beige = Color(0xFFF4F1E4);
  static const Color brown = Color(0xFF8B5500);
  static const Color yellow = Color(0xFFC0C000);
}

class PlacetteCycleWidgetState extends ConsumerState<PlacetteCycleWidget> {
  PlacetteCycleWidgetState();

  late List<bool> cycleSelected;

  @override
  void initState() {
    super.initState();
    cycleSelected =
        widget.dispCycleList!.values.map<bool>((Cycle data) => false).toList();
    if (cycleSelected.isNotEmpty) {
      cycleSelected[0] = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final corCyclePlacetteLocalStorageStatusProvider = ref.watch(
        corCyclePlacetteLocalStorageStatusStateNotifierProvider.notifier);

    // Determine the selected cycle's idCycle
    int selectedCycleIndex = cycleSelected.indexWhere((selected) => selected);
    Cycle? selectedCycle = selectedCycleIndex != -1
        ? widget.dispCycleList!.values.elementAt(selectedCycleIndex)
        : null;

    CorCyclePlacette? selectedCorCyclePlacette;

    // Iterate over corCyclePlacetteList to find the matching element
    for (var corCyclePlacette in widget.corCyclePlacetteList.values) {
      if (selectedCycle != null &&
          corCyclePlacette.idCycle == selectedCycle.idCycle) {
        selectedCorCyclePlacette = corCyclePlacette;
        break; // Break the loop once the matching element is found
      }
    }

    // Check if the cycle placette is new using idCyclePlacette
    bool isNewCycle = selectedCorCyclePlacette != null &&
        corCyclePlacetteLocalStorageStatusProvider.isCyclePlacetteInProgress(
            selectedCorCyclePlacette.idCyclePlacette);
    Cycle lastCycle = widget.dispCycleList!.findIdOfCycleWithLargestNumCycle()!;
    CorCyclePlacette? lastCorCyclePlacette = widget.corCyclePlacetteList
        .getCorCyclePlacetteByIdCycle(lastCycle.idCycle);

    // Use ThemeData to manage common style properties
    final ThemeData theme = Theme.of(context).copyWith(
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(backgroundColor: AppColors.blue2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.beige,
          backgroundColor: AppColors.green,
          textStyle: const TextStyle(color: AppColors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.green;
          }
          return null;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.green;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.green;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.green;
          }
          return null;
        }),
      ),
    );

    return Theme(
      data: theme,
      child: Column(
        children: [
          ToggleButtons(
            isSelected: cycleSelected,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < cycleSelected.length; i++) {
                  cycleSelected[i] = i == index;
                }
              });
            },
            borderRadius: BorderRadius.circular(20),
            selectedBorderColor: AppColors.blue1,
            selectedColor: AppColors.beige,
            fillColor: AppColors.blue2,
            color: AppColors.black,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 90.0,
            ),
            children: _generateCircleAvatars(
              widget.dispCycleList!,
              widget.corCyclePlacetteList,
              corCyclePlacetteLocalStorageStatusProvider,
            ),
          ),
          // La possibilité de marquer un cycle comme complet ou non terminé dépend de la date de fin du cycle (si null alors le cycle n'est pas fini)
          if (!widget.dispCycleList!.cyclesAreTerminated()) ...[
            if (isNewCycle) ...[
              ElevatedButton(
                onPressed: () async {
                  await corCyclePlacetteLocalStorageStatusProvider
                      .completeCycle(selectedCorCyclePlacette!.idCyclePlacette);
                  setState(() {});
                },
                child: const Text('Marquer comme complet'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return FormSaisiePlacettePage(
                      formType: "edit",
                      type: 'corCyclePlacette',
                      placette: widget.placette,
                      cycle: selectedCycle!,
                      corCyclePlacette: selectedCorCyclePlacette,
                    );
                  },
                )),
                child: const Text('Mettre à jour'),
              ),
            ],
            if (selectedCorCyclePlacette != null &&
                !isNewCycle &&

                // Check if the cycle placette is the last cycle
                lastCorCyclePlacette != null &&
                selectedCorCyclePlacette.idCyclePlacette ==
                    lastCorCyclePlacette.idCyclePlacette) ...[
              ElevatedButton(
                onPressed: () async {
                  await corCyclePlacetteLocalStorageStatusProvider
                      .unCompleteCycle(
                          selectedCorCyclePlacette!.idCyclePlacette);
                  setState(() {});
                },
                child: const Text('Marquer comme non terminé'),
              ),
            ],
          ],

          // Afficher le grid seulement si le corcycle existe pour la placette
          // Sinon Afficher un text et un bouton
          widget.corCyclePlacetteList.values
                  .map((CorCyclePlacette corCyclePla) => corCyclePla.idCycle)
                  .contains(widget
                      .dispCycleList![cycleSelected
                          .indexWhere((selected) => selected == true)]
                      .idCycle)
              ? __buildGridText(widget.corCyclePlacetteList[
                  cycleSelected.indexWhere((selected) => selected == true)])
              : NoCycleWidget(
                  placette: widget.placette,
                  cycle: widget.dispCycleList![cycleSelected
                      .indexWhere((selected) => selected == true)]),
        ],
      ),
    );
  }
}

List<Widget> _generateCircleAvatars(
  CycleList dispCycleList,
  CorCyclePlacetteList corCyclePlacetteList,
  CorCyclePlacetteLocalStorageStatusNotifier
      corCyclePlacetteLocalStorageStatusStateNotifier,
) {
  return dispCycleList.values.map<Widget>((Cycle data) {
    CorCyclePlacette? correspondingCorCyclePlacette;

    // Iterate over corCyclePlacetteList to find the matching element
    for (var corCyclePlacette in corCyclePlacetteList.values) {
      if (corCyclePlacette.idCycle == data.idCycle) {
        correspondingCorCyclePlacette = corCyclePlacette;
        break; // Break the loop once the matching element is found
      }
    }

    // Determine the appropriate background color
    Color backgroundColor = correspondingCorCyclePlacette != null
        ? (corCyclePlacetteLocalStorageStatusStateNotifier
                .isCyclePlacetteInProgress(
                    correspondingCorCyclePlacette.idCyclePlacette)
            ? AppColors.yellow // New cycle color
            : AppColors.blue1) // Existing cycle
        : AppColors.brown; // Cycle not found

    return CircleAvatar(
      backgroundColor: backgroundColor,
      foregroundColor: AppColors.beige,
      radius: 15, // Increased size for better visibility
      child: Text(
        data.numCycle.toString(),
        style: const TextStyle(color: AppColors.black),
      ),
    );
  }).toList();
}

Widget __buildGridText(CorCyclePlacette corCyclePlacette) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(10.0), // Added padding for spacing
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (1 / .2), // Adjusted for better spacing
        children: [
          buildPropertyTextWidget(
              'idCyclePlacette', corCyclePlacette.idCyclePlacette),
          buildPropertyTextWidget('idCycle', corCyclePlacette.idCycle),
          buildPropertyTextWidget('idPlacette', corCyclePlacette.idPlacette),
          buildPropertyTextWidget(
              'dateReleve',
              corCyclePlacette.dateReleve != null
                  ? '${corCyclePlacette.dateReleve!.day}/${corCyclePlacette.dateReleve!.month}/${corCyclePlacette.dateReleve!.year}'
                  : null),
          buildPropertyTextWidget(
              'dateIntervention', corCyclePlacette.dateIntervention),
          buildPropertyTextWidget('annee', corCyclePlacette.annee),
          buildPropertyTextWidget(
              'natureIntervention', corCyclePlacette.natureIntervention),
          buildPropertyTextWidget(
              'gestionPlacette', corCyclePlacette.gestionPlacette),
          buildPropertyTextWidget(
              'idNomenclatureCastor', corCyclePlacette.idNomenclatureCastor),
          buildPropertyTextWidget(
              'idNomenclatureFrottis', corCyclePlacette.idNomenclatureFrottis),
          buildPropertyTextWidget(
              'idNomenclatureBoutis', corCyclePlacette.idNomenclatureBoutis),
          buildPropertyTextWidget(
              'recouvHerbesBasses', corCyclePlacette.recouvHerbesBasses),
          buildPropertyTextWidget(
              'recouvHerbesHautes', corCyclePlacette.recouvHerbesHautes),
          buildPropertyTextWidget(
              'recouvBuissons', corCyclePlacette.recouvBuissons),
          buildPropertyTextWidget(
              'recouvArbres', corCyclePlacette.recouvArbres),
          buildPropertyTextWidget('coeff', corCyclePlacette.coeff),
          buildPropertyTextWidget('diamLim', corCyclePlacette.diamLim),
        ]
            .map((widget) => Container(
                  padding:
                      const EdgeInsets.all(4), // Padding inside each grid cell
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: widget,
                ))
            .toList(),
      ),
    ),
  );
}

class NoCycleWidget extends ConsumerWidget {
  NoCycleWidget({Key? key, required this.placette, required this.cycle})
      : super(key: key);

  Placette placette;
  Cycle cycle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Ce cycle n'a pas été réalisé pour cette placette",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return FormSaisiePlacettePage(
                  formType: "add",
                  type: 'corCyclePlacette',
                  placette: placette,
                  cycle: cycle,
                  corCyclePlacette: null,
                );
              },
            )),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.green),
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            ),
            child: const Text(
              "Ajouter un cycle",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
