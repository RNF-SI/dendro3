import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:flutter/material.dart';

class PrimaryGridWidget extends StatelessWidget {
  final List<MapEntry<String, dynamic>> simpleElements;
  final Function(dynamic) onItemAdded;
  final Function(dynamic) onItemDeleted;
  final Function(dynamic) onItemUpdated;
  final String displayTypeState;

  PrimaryGridWidget({
    Key? key,
    required this.simpleElements,
    required this.onItemAdded,
    required this.onItemDeleted,
    required this.onItemUpdated,
    required this.displayTypeState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // remove the elements of simpleElements that are not in the displayable columns
    simpleElements.removeWhere(
        (element) => !shouldIncludeColumn(element.key, displayTypeState));

    List<Widget> simpleWidgets =
        simpleElements.map((MapEntry<String, dynamic> entry) {
      return Container(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                "${entry.key}:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Text(
                entry.value.toString(),
                style: TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () =>
                  onItemUpdated(simpleElements), // Using onItemMesureUpdated
              iconSize: 18, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () =>
                  onItemDeleted(simpleElements), // Using onItemMesureDeleted
              iconSize: 18, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.green),
              onPressed: () =>
                  onItemAdded(simpleElements), // Using onItemMesureDeleted
              iconSize: 20, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20), // Ajout d'une marge en haut
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 2,
            children: simpleWidgets,
          ),
        ),
      ],
    );
  }

  bool shouldIncludeColumn(String columnName, String type) {
    switch (type) {
      case 'Arbres':
        return Arbre.getDisplayableColumn(columnName);
      case 'BmsSup30':
        return BmSup30.getDisplayableColumn(columnName);
      case 'Reperes':
        return Repere.getDisplayableColumn(columnName);
      case 'Regenerations':
        return Regeneration.getDisplayableColumn(columnName);
      case 'Transects':
        return Transect.getDisplayableColumn(columnName);
    }
    return true;
  }
}
