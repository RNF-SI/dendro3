import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:flutter/material.dart';

import '../lib/simple_element.dart';

class PrimaryGridWidget extends StatelessWidget {
  final SimpleElement simpleElements;
  final Function(dynamic) onItemAdded;
  final Function(dynamic) onItemDeleted;
  final Function(dynamic) onItemUpdated;
  final String displayTypeState;
  final Map<int, int> mapNumCyclePlacetteNumCycle;

  PrimaryGridWidget({
    Key? key,
    required this.simpleElements,
    required this.onItemAdded,
    required this.onItemDeleted,
    required this.onItemUpdated,
    required this.displayTypeState,
    required this.mapNumCyclePlacetteNumCycle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace idCyclePlacette value by with NumCycle value
    if (simpleElements.containsKey('idCyclePlacette')) {
      int? numCyclePlacette = mapNumCyclePlacetteNumCycle[
          simpleElements.getValue('idCyclePlacette')!];
      if (numCyclePlacette != null) {
        simpleElements.setValue('idCyclePlacette', numCyclePlacette);
      }
    }

    // remove the elements of simpleElements that are not in the displayable columns
    simpleElements.removeWhere(
        (element) => !shouldIncludeColumn(element.key, displayTypeState));

    // Map for title name changes
    List<String> titleNames = _getTitleGridNamesForType(
        simpleElements.map((e) => e.key).toList(), displayTypeState);

    List<Widget> simpleWidgets = [];
    for (int i = 0; i < simpleElements.length; i++) {
      MapEntry<String, dynamic> entry = simpleElements.entries[i];
      String titleName = titleNames[i]; // Get the modified title name

      // Determine the display value
      String displayValue;
      if (entry.value is double) {
        double doubleValue = entry.value as double;
        displayValue = doubleValue == doubleValue.toInt()
            ? doubleValue.toInt().toString()
            : doubleValue.toStringAsFixed(1);
      } else {
        displayValue = entry.value.toString();
      }

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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                child: Text(
                  displayValue,
                  style: TextStyle(fontSize: 15),
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
            if (displayTypeState != 'Arbres' && displayTypeState != 'BmsSup30')
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
              onPressed: () {
                // Show confirmation dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmer la suppression'),
                      content: Text(
                          'Etes vous sûr de vouloir supprimer cet élément?'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Annuler'),
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Supprimer',
                              style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            // Close the dialog
                            Navigator.of(context).pop();
                            // Perform the delete action
                            onItemDeleted(simpleElements);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              iconSize: 18, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
            // IconButton(
            //   icon: Icon(Icons.add, color: Colors.green),
            //   onPressed: () =>
            //       onItemAdded(simpleElements), // Using onItemMesureDeleted
            //   iconSize: 20, // Reduced icon size
            //   padding: EdgeInsets.all(4), // Reduced padding
            //   constraints: BoxConstraints(),
            // ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20), // Ajout d'une marge en haut
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 2.5,
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
