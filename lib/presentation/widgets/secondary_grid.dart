import 'dart:math';
import 'package:dendro3/presentation/lib/screen_size_provider.dart';
import 'package:dendro3/presentation/widgets/action_button.dart';
import 'package:dendro3/presentation/widgets/expandingFAB.dart';
import 'package:flutter/material.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondaryGrid extends ConsumerStatefulWidget {
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

class _SecondaryGridState extends ConsumerState<SecondaryGrid> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ScreenSize screenSize = ref.watch(screenSizeProvider(context));
    double paddingTopStack,
        fontSizeTitle,
        fontSizeText,
        mainAxisSpacing,
        childAspectRatio,
        crossAxisSpacing;
    int crossAxisCount;

    switch (screenSize) {
      case ScreenSize.small:
        paddingTopStack = 5;
        fontSizeTitle = 10;
        fontSizeText = 12;
        mainAxisSpacing = 1;
        crossAxisCount = 3;
        childAspectRatio = 2.5;
        crossAxisSpacing = 1;
        break;
      case ScreenSize.medium:
        paddingTopStack = 10;
        fontSizeTitle = 13;
        fontSizeText = 16;
        mainAxisSpacing = 3;
        crossAxisCount = 3;
        childAspectRatio = 2;
        crossAxisSpacing = 5;
        break;
      case ScreenSize.large:
        paddingTopStack = 10;
        fontSizeTitle = 13;
        fontSizeText = 16;
        mainAxisSpacing = 3;
        crossAxisCount = 4;
        childAspectRatio = 1.5;
        crossAxisSpacing = 2;
        break;
    }

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
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: paddingTopStack,
                          right: 30,
                          left: 10), // Ensure enough padding for icons
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: mainAxisSpacing,
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                          crossAxisSpacing: crossAxisSpacing,
                        ),
                        itemCount: currentItem.entries.length,
                        itemBuilder: (context, itemIndex) {
                          var entry = currentItem.entries.elementAt(itemIndex);
                          List<String> titleGridNames =
                              _getTitleGridNamesForType(
                                  currentItem.keys.toList(),
                                  widget.displayTypeState);
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSizeTitle,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  displayValue,
                                  style: TextStyle(fontSize: fontSizeText),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: ExpandingFAB(
                        distance: 46.0,
                        heroTag: "secondaryGridHeroTag$index",
                        children: [
                          // La mesure ne peut être supprimée que si elle est dans le dernier cycle de la placette
                          // ou bien si il y a plus de 1 mesure de cet arbre
                          if (maxNumberCyclePlacette ==
                                  currentItem['numCycle'] &&
                              widget.mesuresList.length > 1)
                            ActionButton(
                              icon: const Icon(Icons.delete,
                                  color: Color(0xFF8B5500)),
                              onPressed: () {
                                // Show confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Confirmer la suppression'),
                                      content: const Text(
                                          'Etes vous sûr de vouloir supprimer cet élément?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Annuler'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        TextButton(
                                          child: const Text('Supprimer',
                                              style: TextStyle(
                                                  color: Color(0xFF8B5500))),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            widget.onItemMesureDeleted(
                                                widget.mesuresList[index]);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ActionButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              widget.onItemMesureUpdated(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
