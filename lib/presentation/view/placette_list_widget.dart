import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_list_viewmodel.dart';
import 'package:dendro3/presentation/widgets/placette_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacetteListWidget extends ConsumerStatefulWidget {
  final CycleList cycleList;
  // final PlacetteList placetteList;

  const PlacetteListWidget({
    Key? key,
    required this.cycleList,
    // required this.placetteList,
  }) : super(key: key);

  @override
  _PlacetteListWidgetState createState() => _PlacetteListWidgetState();
}

class _PlacetteListWidgetState extends ConsumerState<PlacetteListWidget> {
  @override
  Widget build(BuildContext context) {
    final PlacetteList? placetteList = ref.watch(placetteListProvider);

    if (placetteList == null || placetteList.isEmpty()) {
      return const Center(child: Text('Pas de Placette'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: placetteList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return PlacetteItemCardWidget(
            placette: placetteList[index],
            cycleList: widget.cycleList,
          );
        },
      );
    }
  }
}
