import 'dart:math';

import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/presentation/widgets/conditional_tooltip_text.dart';
import 'package:flutter/material.dart';

class SecondaryGrid extends StatefulWidget {
  final Map<int, int> mapIdCycleNumCycle;
  final List<dynamic> mesuresList;
  final Function(int) onItemSelected;
  final Function(dynamic) onItemMesureAdded;
  final Function(dynamic) onItemMesureDeleted;
  final Function(int) onItemMesureUpdated;
  final int currentIndex;
  final String displayTypeState;

  SecondaryGrid({
    Key? key,
    required this.mesuresList,
    required this.onItemSelected,
    required this.onItemMesureAdded,
    required this.onItemMesureDeleted,
    required this.onItemMesureUpdated,
    required this.currentIndex,
    required this.mapIdCycleNumCycle,
    required this.displayTypeState,
  }) : super(key: key);

  @override
  _SecondaryGridState createState() => _SecondaryGridState();
}

class _SecondaryGridState extends State<SecondaryGrid> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.currentIndex;
    if (widget.mesuresList.isEmpty) {
      return SizedBox.shrink(); // Return an empty widget if the list is empty
    }

    var maxNumberCyclePlacette = widget.mapIdCycleNumCycle.isNotEmpty
        ? widget.mapIdCycleNumCycle.values.reduce(max)
        : null;
    var maxIdCyclePlacette = maxNumberCyclePlacette != null
        ? widget.mapIdCycleNumCycle.keys.firstWhere(
            (k) => widget.mapIdCycleNumCycle[k] == maxNumberCyclePlacette)
        : null;

    return
        // Column(
        //   children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     IconButton(
        //       icon: Icon(Icons.edit),
        //       onPressed: () {
        //         widget.onItemMesureUpdated(widget.mesuresList[currentIndex]);
        //       },
        //       iconSize: 18, // Reduced icon size
        //       padding: EdgeInsets.all(4), // Reduced padding
        //       constraints: BoxConstraints(),
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.delete, color: Colors.red),
        //       onPressed: () {
        //         widget.onItemMesureDeleted(widget.mesuresList[currentIndex]);
        //       },
        //       iconSize: 18, // Reduced icon size
        //       padding: EdgeInsets.all(4), // Reduced padding
        //       constraints: BoxConstraints(),
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.add, color: Colors.green),
        //       onPressed: () {
        //         widget.onItemMesureAdded(widget.mesuresList[currentIndex]);
        //       },
        //       iconSize: 18, // Reduced icon size
        //       padding: EdgeInsets.all(4), // Reduced padding
        //       constraints: BoxConstraints(),
        //     ),
        //   ],
        // ),
        ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.mesuresList.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.mesuresList.length) {
          if (widget.mapIdCycleNumCycle.isEmpty) {
            return SizedBox.shrink();
          }

          // Afficher le bouton ajout seulement si le dernier cycle de la mesure n'est pas le dernier cycle de la placette
          if (widget.mesuresList.last['idCycle'] != maxIdCyclePlacette) {
            // Return the "Add New Measure" element
            return GestureDetector(
              onTap: () {
                widget.onItemMesureAdded(widget.mesuresList[currentIndex]);
              },
              child: Container(
                width: 200, // Same width as other items
                height: 120,
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  color: Colors.greenAccent, // Different color to distinguish
                  child: Center(
                    child: Icon(Icons.add,
                        size: 50, color: Colors.white), // Add icon
                  ),
                ),
              ),
            );
          } else {
            return SizedBox
                .shrink(); // Return an empty widget for non-last cycles
          }
        }

        // // Check if this is the last item
        // if (index == widget.mesuresList.length) {
        //   // Return the "Add New Measure" element
        //   return GestureDetector(
        //     onTap: () {
        //       // Handle the addition of a new measure here
        //       widget.onItemMesureAdded(widget.mesuresList[currentIndex]);
        //     },
        //     child: Container(
        //       width: 200, // Same width as other items
        //       height: 200,
        //       margin: const EdgeInsets.symmetric(horizontal: 5),
        //       child: const Card(
        //         color: Colors.greenAccent, // Different color to distinguish
        //         child: Center(
        //           child: Icon(
        //             Icons.add,
        //             size: 50,
        //             color: Colors.white,
        //           ), // Add icon
        //         ),
        //       ),
        //     ),
        //   );
        // }

        Map<String, dynamic> currentItem = widget.mesuresList[index];

        currentItem = filterMesureItem(currentItem, widget.displayTypeState);

        return Container(
          width: 300,
          height: 120, // Define the width for each item
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        widget.onItemMesureUpdated(index);
                      },
                      iconSize: 18, // Reduced icon size
                      padding: EdgeInsets.all(4), // Reduced padding
                      constraints: BoxConstraints(),
                    ),
                    // La mesure ne peut être supprimée que si elle est dans le dernier cycle de la placette
                    // ou bien si il y a plus de 1 mesure de cet arbre
                    if (maxIdCyclePlacette == currentItem['idCycle'] &&
                        widget.mesuresList.length > 1)
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
                                      widget.onItemMesureDeleted(
                                          widget.mesuresList[index]);
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
                    //   onPressed: () {
                    //     widget.onItemMesureAdded(
                    //         widget.mesuresList[currentIndex]);
                    //   },
                    //   iconSize: 18, // Reduced icon size
                    //   padding: EdgeInsets.all(4), // Reduced padding
                    //   constraints: BoxConstraints(),
                    // ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8),

                  child: GridView.builder(
                    shrinkWrap: true,
                    physics:
                        NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // Number of columns in the grid
                      childAspectRatio: 2, // Aspect ratio of each grid cell
                    ),
                    itemCount: currentItem.entries.length,
                    itemBuilder: (context, itemIndex) {
                      var entry = currentItem.entries.elementAt(itemIndex);
                      List<String> titleGridNames = _getTitleGridNamesForType(
                          currentItem.keys.toList(), widget.displayTypeState);
                      String titleName = titleGridNames[
                          itemIndex]; // Get the modified title name

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

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "$titleName:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
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
                      );
                    },
                  ),

                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: currentItem.entries.map((entry) {
                  //     return Padding(
                  //       padding: const EdgeInsets.only(bottom: 2.0),
                  //       child: Text("${entry.key}: ${entry.value}"),
                  //     );
                  //   }).toList(),
                  // ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Map<String, dynamic> filterMesureItem(
      Map<String, dynamic> item, String type) {
    Map<String, dynamic> filteredItem = {};
    item.forEach((key, value) {
      if (shouldIncludeColumn(key, type)) {
        filteredItem[key] = value;
      }
    });
    return filteredItem;
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
      default:
        throw ArgumentError('Unknown type: ${type}');
    }
  }
}
