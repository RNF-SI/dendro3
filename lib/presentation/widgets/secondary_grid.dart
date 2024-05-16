import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';

class SecondaryGrid extends StatefulWidget {
  final Map<int, int> mapIdCycleNumCycle;
  final List<dynamic> mesuresList;
  final Function(int) onItemSelected;
  final Function(dynamic) onItemMesureAdded;
  final Function(dynamic) onItemMesureDeleted;
  final Function(int) onItemMesureUpdated;
  final int currentIndex;
  final String displayTypeState;

  const SecondaryGrid({
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
    double screenWidth = MediaQuery.of(context).size.width;
    double scale =
        screenWidth / 360; // scale factor based on typical screen width

    // Sort mesuresList based on the order of cycles in mapIdCycleNumCycle
    widget.mesuresList.sort((a, b) {
      int cycleNumA = widget.mapIdCycleNumCycle[a['idCycle']] ?? 0;
      int cycleNumB = widget.mapIdCycleNumCycle[b['idCycle']] ?? 0;
      return cycleNumA.compareTo(cycleNumB);
    });
    currentIndex = widget.currentIndex;
    if (widget.mesuresList.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if the list is empty
    }
    var maxNumberCyclePlacette = widget.mapIdCycleNumCycle.isNotEmpty
        ? widget.mapIdCycleNumCycle.values.reduce(max)
        : null;
    var maxIdCyclePlacette = maxNumberCyclePlacette != null
        ? widget.mapIdCycleNumCycle.keys.firstWhere(
            (k) => widget.mapIdCycleNumCycle[k] == maxNumberCyclePlacette)
        : null;
    var lastPassageIdCyclePlacette = (maxNumberCyclePlacette != null &&
            maxNumberCyclePlacette > 1)
        ? widget.mapIdCycleNumCycle.keys.firstWhere(
            (k) => widget.mapIdCycleNumCycle[k] == maxNumberCyclePlacette - 1)
        : null;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.mesuresList.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.mesuresList.length) {
          if (widget.mapIdCycleNumCycle.isEmpty) {
            return const SizedBox.shrink();
          }

          // Afficher le bouton ajout seulement si le dernier cycle de la mesure n'est pas le dernier cycle de la placette
          // Et qu'il n'y a pas eu de saut de cycle: que le cycle précédent soit le dernier cycle de la placette
          if (widget.mesuresList.last['idCycle'] != maxIdCyclePlacette &&
              widget.mesuresList.last['idCycle'] ==
                  lastPassageIdCyclePlacette) {
            // Return the "Add New Measure" element
            return GestureDetector(
              onTap: () {
                widget.onItemMesureAdded(widget.mesuresList[currentIndex]);
              },
              child: Container(
                width: 200 * scale, // Same width as other items
                height: 120 * scale,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: const Card(
                  color: Color(0xFF8AAC3E), // Different color to distinguish
                  child: Center(
                    child: Icon(Icons.add,
                        size: 50, color: Colors.white), // Add icon
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox
                .shrink(); // Return an empty widget for non-last cycles
          }
        }

        Map<String, dynamic> currentItem = widget.mesuresList[index];

        // Replace idCycle with NumCycle
        if (currentItem.containsKey('idCycle')) {
          int? numCycle = widget.mapIdCycleNumCycle[currentItem['idCycle']];
          if (numCycle != null) {
            Map<String, dynamic> updatedItem = {
              'numCycle':
                  numCycle, // Add numCycle property at the first position
            };
            // Copy the rest of the entries from the original currentItem map
            updatedItem.addAll(currentItem);
            // Update currentItem with the updated map
            currentItem = updatedItem;
          }
        }

        currentItem = filterMesureItem(currentItem, widget.displayTypeState);

        return Container(
          width: 250 * scale,
          height: 150 * scale,
          margin: EdgeInsets.symmetric(horizontal: 2 * scale),
          child: Card(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        widget.onItemMesureUpdated(index);
                      },
                      iconSize: 18 * scale,
                      padding: EdgeInsets.all(4 * scale),
                      // constraints: const BoxConstraints(),
                    ),
                    // La mesure ne peut être supprimée que si elle est dans le dernier cycle de la placette
                    // ou bien si il y a plus de 1 mesure de cet arbre
                    if (maxNumberCyclePlacette == currentItem['numCycle'] &&
                        widget.mesuresList.length > 1)
                      IconButton(
                        icon:
                            const Icon(Icons.delete, color: Color(0xFF8B5500)),
                        onPressed: () {
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirmer la suppression'),
                                content: const Text(
                                    'Etes vous sûr de vouloir supprimer cet élément?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Annuler'),
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Supprimer',
                                        style: TextStyle(
                                            color: Color(0xFF8B5500))),
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
                        iconSize: 18 * scale,
                        padding: EdgeInsets.all(4 * scale),
                      ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2 * scale, horizontal: 3 * scale),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 3,
                      crossAxisCount: screenWidth > 600 ? 4 : 3,
                      childAspectRatio: 2.5 * scale,
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              displayValue,
                              style: const TextStyle(fontSize: 15),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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
        return Arbre.getDisplayableGridTile(columnName);
      case 'BmsSup30':
        return BmSup30.getDisplayableGridTile(columnName);
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
        throw ArgumentError('Unknown type: $type');
    }
  }
}
