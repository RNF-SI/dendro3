import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/view/placette_page/placette_page.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final corCyclePlacetteListViewModel =
        ref.read(corCyclePlacetteListViewModelStateNotifierProvider.notifier);
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Placette ${placette.idPlacetteOrig}",
                          ),
                          TextSpan(
                            text: "(${placette.idPlacette})",
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.black,
                            ),
                          )
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
                  for (var corCyclePlacette
                      in placette.corCyclesPlacettes!.values) {
                    if (corCyclePlacette.idCycle == data!.idCycle) {
                      currentCorCyclePlacette = corCyclePlacette;
                      break; // Break the loop once the matching element is found
                    }
                  }

                  bool isCyclePlacetteCompleted = false;
                  if (currentCorCyclePlacette != null) {
                    isCyclePlacetteCompleted = corCyclePlacetteListViewModel
                        .isCyclePlacetteCreated(currentCorCyclePlacette!
                            .idCyclePlacette); // Adjust this line based on your actual logic
                  }
                  bool isCyclePlacetteFinished = placette
                      .corCyclesPlacettes!.values
                      .map((CorCyclePlacette corCycle) => corCycle.idCycle)
                      .contains(data.idCycle);
                  return CircleAvatar(
                    backgroundColor: isCyclePlacetteCompleted
                        ? Colors.yellow
                        : isCyclePlacetteFinished
                            ? Colors.green
                            : Colors.red,
                    foregroundColor: Colors.white,
                    radius: 10,
                    child: Text(data.numCycle.toString()),
                  );
                }).toList(),
              ),
              SizedBox(
                width: 76,
                child: IconButton(
                  onPressed: () {
                    corCyclePlacetteListViewModel
                        .setCorCyclePlacetteList(placette.corCyclesPlacettes!);
                    final lastSelectedProvider =
                        ref.watch(lastSelectedIdProvider.notifier);
                    lastSelectedProvider.reset();

                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return PlacettePage(
                          placette: placette,
                          dispCycleList: cycleList,
                        );
                      },
                    ));
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
