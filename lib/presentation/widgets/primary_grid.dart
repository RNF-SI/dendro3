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

    // Map for title name changes
    List<String> titleNames = _getTitleGridNamesForType(
        simpleElements.map((e) => e.key).toList(), displayTypeState);

    List<Widget> simpleWidgets = [];
    for (int i = 0; i < simpleElements.length; i++) {
      MapEntry<String, dynamic> entry = simpleElements[i];
      String titleName = titleNames[i]; // Get the modified title name

      simpleWidgets.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  "$titleName:", // Use the modified title name
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
        ),
      );
    }

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

  List<String> _getTitleGridNamesForType(List<String> columnList, String type) {
    switch (type) {
      case 'Arbres':
        return Arbre.changeTitleGridNames(columnList);
      case 'BmsSup30':
        return BmSup30.changeTitleGridNames(columnList);
      case 'Reperes':
        return Repere.changeTitleGridNames(columnList);
      case 'Regenerations':
        return Regeneration.changeTitleGridNames(columnList);
      case 'Transects':
        return Transect.changeTitleGridNames(columnList);
      default:
        throw ArgumentError('Unknown type: ${type}');
    }
  }
}
