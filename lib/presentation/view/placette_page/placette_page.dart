import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/lib/utils.dart';
import 'package:dendro3/presentation/view/form_saisie_placette_page.dart';
import 'package:dendro3/presentation/view/placette_page/placette_page_cycles.dart';
import 'package:dendro3/presentation/view/saisie_placette_page.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/presentation/widgets/action_button.dart';
import 'package:dendro3/presentation/widgets/expandingFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacettePage extends ConsumerStatefulWidget {
  PlacettePage({
    Key? key,
    // required this.placette,
    required this.dispCycleList,
  }) : super(key: key);

  Placette? placette;
  CycleList dispCycleList;

  @override
  PlacettePageState createState() => PlacettePageState();
}

class PlacettePageState extends ConsumerState<PlacettePage> {
  PlacettePageState();

  @override
  Widget build(
    BuildContext context,
  ) {
    final Placette? placette = ref.watch(placetteProvider);
    final CorCyclePlacetteList corCyclePlacetteList =
        ref.watch(corCyclePlacetteListProvider);
    final corCyclePlacetteLocalStorageStatusProvider = ref.watch(
        corCyclePlacetteLocalStorageStatusStateNotifierProvider.notifier);
    final List<String>? corCyclePlacetteOpened =
        ref.watch(corCyclePlacetteLocalStorageListProvider);
    Cycle lastCycle = widget.dispCycleList!.findIdOfCycleWithLargestNumCycle()!;
    CorCyclePlacette? lastCorCyclePlacette =
        corCyclePlacetteList.getCorCyclePlacetteByIdCycle(lastCycle.idCycle);

    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text('Placette ${placette!.idPlacetteOrig}'),
                const SizedBox(width: 8),
                Text(
                  '(DISP ${placette.idDispositif})',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.summarize),
                  text: 'Résumé',
                ),
                Tab(
                  icon: Icon(Icons.onetwothree),
                  text: 'Cycles',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              __buildPlacetteResumeWidget(
                context,
                ref,
                placette,
              ),
              PlacetteCycleWidget(
                placette: placette,
                corCyclePlacetteList: corCyclePlacetteList,
                dispCycleList: widget.dispCycleList,
              ),
            ],
          ),
          floatingActionButton: ((corCyclePlacetteList.length ==
                      widget.dispCycleList.length) &&
                  (lastCorCyclePlacette != null) &&
                  corCyclePlacetteOpened != null &&
                  corCyclePlacetteLocalStorageStatusProvider
                      .isCyclePlacetteInProgress(
                          lastCorCyclePlacette.idCyclePlacette))
              ? ExpandingFAB(
                  distance: 112.0,
                  children: [
                    ActionButton(
                      onPressed: corCyclePlacetteList.length ==
                              widget.dispCycleList.length
                          ? () =>
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return SaisiePlacettePage(
                                    placette: placette,
                                    corCyclePlacetteList: corCyclePlacetteList,
                                    dispCycleList: widget.dispCycleList,
                                  );
                                },
                              ))
                          : null, // Make button not clickable when the lists have the same length
                      icon: Icon(
                        Icons.add,
                        color: corCyclePlacetteList.length ==
                                widget.dispCycleList.length
                            ? Color(0xFFF4F1E4)
                            : Color(0xFF8B5500),
                      ),
                    ),
                  ],
                )
              : null),
    );
  }
}

Widget __buildPlacetteResumeWidget(
    BuildContext context, WidgetRef ref, Placette placette) {
  List<Map<String, dynamic>> properties = [
    {'property': 'idPlacette', 'value': placette.idPlacette},
    {'property': 'idDispositif', 'value': placette.idDispositif},
    {'property': 'idPlacetteOrig', 'value': placette.idPlacetteOrig},
    {'property': 'strate', 'value': placette.strate},
    {'property': 'pente', 'value': placette.pente},
    {'property': 'poidsPlacette', 'value': placette.poidsPlacette},
    {'property': 'correctionPente', 'value': placette.correctionPente},
    {'property': 'exposition', 'value': placette.exposition},
    {'property': 'profondeurApp', 'value': placette.profondeurApp},
    {'property': 'profondeurHydr', 'value': placette.profondeurHydr},
    {'property': 'texture', 'value': placette.texture},
    {'property': 'habitat', 'value': placette.habitat},
    {
      'property': 'station',
      'value': placette.station,
      'isLong': true,
    },
    {'property': 'typologie', 'value': placette.typologie},
    {'property': 'groupe', 'value': placette.groupe},
    {'property': 'groupe1', 'value': placette.groupe1},
    {'property': 'groupe2', 'value': placette.groupe2},
    {'property': 'refHabitat', 'value': placette.refHabitat},
    {
      'property': 'precisionHabitat',
      'value': placette.precisionHabitat,
      'isLong': true
    },
    {
      'property': 'refStation',
      'value': placette.refStation,
      'isLong': true,
    },
    {'property': 'refTypologie', 'value': placette.refTypologie},
    {'property': 'descriptifGroupe', 'value': placette.descriptifGroupe},
    {'property': 'descriptifGroupe1', 'value': placette.descriptifGroupe1},
    {'property': 'descriptifGroupe2', 'value': placette.descriptifGroupe2},
    {'property': 'precisionGps', 'value': placette.precisionGps},
    {'property': 'cheminement', 'value': placette.cheminement},
  ];

  List<Map<String, dynamic>> regularProperties = [];
  List<Map<String, dynamic>> longTextProperties = [];

  for (var property in properties) {
    if (property.containsKey('isLong') && property['isLong']) {
      longTextProperties.add(property);
    } else {
      regularProperties.add(property);
    }
  }

  return CustomScrollView(
    slivers: [
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var property = regularProperties[index];
            return buildPropertyTextWidget(
              property['property'],
              property['value'],
            );
          },
          childCount: regularProperties.length,
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            var property = longTextProperties[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildLongPropertyTextWidget(
                  property['property'], property['value']),
            );
          },
          childCount: longTextProperties.length,
        ),
      ),
      // Adding a new SliverToBoxAdapter to include a button
      SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return FormSaisiePlacettePage(
                      formType: "edit",
                      type: 'Placette',
                      placette: placette,
                      cycle: null,
                      corCyclePlacette: null,
                    );
                  },
                ));
              },
              icon: Icon(Icons.refresh), // Icon for visual indication
              label: Text('Modifier les données'),
              style: ElevatedButton.styleFrom(
                // foregroundColor: Colors.white,
                // backgroundColor: Colors.blue, // Text color
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
