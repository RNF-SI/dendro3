import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/view/placette_page/placette_page.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/cor_cycle_placette_local_storage_provider.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';

class PlacetteItemCardWidget extends ConsumerWidget {
  const PlacetteItemCardWidget({
    Key? key,
    required this.placette,
    required this.cycleList,
  }) : super(key: key);

  final Placette placette;
  final CycleList cycleList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Color definitions based on your color palette
    const Color colorBlue = Color(0xFF598979);
    const Color colorGreen = Color(0xFF8AAC3E);
    const Color colorLightBlue = Color(0xFF7DAB9C);
    const Color colorBlack = Color(0xFF1A1A18);
    const Color colorBeige = Color(0xFFF4F1E4);
    const Color colorBrown = Color(0xFF8B5500);
    // Color between green and brown
    const Color colorYellow = Color(0xFFC0C000);

    final placetteViewModel =
        ref.watch(placetteViewModelStateNotifierProvider.notifier);
    final corCyclePlacetteListViewModel =
        ref.watch(corCyclePlacetteListViewModelStateNotifierProvider.notifier);

    final corCyclePlacetteLocalStorageStatusProvider = ref.watch(
        corCyclePlacetteLocalStorageStatusStateNotifierProvider.notifier);
    final corCyclePlacetteLocalStorageStatusList =
        ref.watch(corCyclePlacetteLocalStorageStatusStateNotifierProvider);

    final currentCorCyclePlacetteList = ref.watch(corCyclePlacetteListProvider);

    return InkWell(
      child: Card(
        color: colorBeige, // Card background color
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18.0,
                          color: colorBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Placette ${placette.idPlacetteOrig}",
                          ),
                          TextSpan(
                            text: " (${placette.idPlacette})",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colorBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              Wrap(
                spacing: 4,
                children: cycleList.values.map<Widget>((Cycle data) {
                  CorCyclePlacette? currentCorCyclePlacette;
                  // Iterate over corCyclePlacetteList to find the matching element
                  if (currentCorCyclePlacetteList.isEmpty() ||
                      !currentCorCyclePlacetteList
                          .hasCorCyclePlacetteByIdCycleAndIdplacette(
                              data.idCycle, placette.idPlacette)) {
                    for (var corCyclePlacette
                        in placette.corCyclesPlacettes!.values) {
                      if (corCyclePlacette.idCycle == data.idCycle) {
                        currentCorCyclePlacette = corCyclePlacette;
                        break; // Break the loop once the matching element is found
                      }
                    }
                  } else {
                    currentCorCyclePlacette = currentCorCyclePlacetteList
                        .getCorCyclePlacetteByIdCycle(data.idCycle);
                  }

                  bool isCyclePlacetteInProgress = false;
                  // bool isCyclePlacetteFinished = false;
                  if (currentCorCyclePlacette != null) {
                    // is In progress if idCyclePlacette in the list
                    isCyclePlacetteInProgress =
                        corCyclePlacetteLocalStorageStatusList
                            .contains(currentCorCyclePlacette.idCyclePlacette);
                  }
                  bool isCyclePlacetteFinished = placette
                      .corCyclesPlacettes!.values
                      .map((CorCyclePlacette corCycle) => corCycle.idCycle)
                      .contains(data.idCycle);

                  Color bgColor = isCyclePlacetteInProgress
                      ? colorYellow
                      : isCyclePlacetteFinished
                          ? colorBlue
                          : colorBrown;
                  return CircleAvatar(
                    backgroundColor: bgColor,
                    foregroundColor: colorBeige,
                    radius: 12,
                    child: Text(data.numCycle.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
              SizedBox(
                width: 76,
                child: IconButton(
                  onPressed: () {
                    placetteViewModel.setPlacette(placette);

                    corCyclePlacetteListViewModel
                        .setCorCyclePlacetteList(placette.corCyclesPlacettes!);

                    final lastSelectedProvider =
                        ref.watch(lastSelectedIdProvider.notifier);
                    lastSelectedProvider.reset();

                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return PlacettePage(
                          dispCycleList: cycleList,
                        );
                      },
                    )).then((_) {
                      ref
                          .read(
                              corCyclePlacetteListViewModelStateNotifierProvider
                                  .notifier)
                          .refreshList();
                      corCyclePlacetteLocalStorageStatusProvider.refreshList();
                    });
                  },
                  icon: const Icon(
                    Icons.visibility,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
