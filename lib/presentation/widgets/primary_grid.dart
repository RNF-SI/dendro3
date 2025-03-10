import 'package:dendro3/presentation/lib/screen_size_provider.dart';
import 'package:dendro3/presentation/widgets/action_button.dart';
import 'package:dendro3/presentation/widgets/expandingFAB.dart';
import 'package:flutter/material.dart';
import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:dendro3/presentation/lib/simple_element.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimaryGridWidget extends ConsumerStatefulWidget {
  final SimpleElement simpleElements;
  final Function(dynamic) onItemAdded;
  final Function(dynamic) onItemDeleted;
  final Function(dynamic) onItemUpdated;
  final String displayTypeState;
  final Map<String, int> mapNumCyclePlacetteNumCycle;

  const PrimaryGridWidget({
    Key? key,
    required this.simpleElements,
    required this.onItemAdded,
    required this.onItemDeleted,
    required this.onItemUpdated,
    required this.displayTypeState,
    required this.mapNumCyclePlacetteNumCycle,
  }) : super(key: key);

  @override
  _PrimaryGridWidgetState createState() => _PrimaryGridWidgetState();
}

class _PrimaryGridWidgetState extends ConsumerState<PrimaryGridWidget> {
  @override
  Widget build(BuildContext context) {
    // Screen width for responsive layout
    double screenWidth = MediaQuery.of(context).size.width;
    double scale =
        screenWidth / 360; // Base scale on typical small screen width
    final ScreenSize screenSize = ref.watch(screenSizeProvider(context));
    double fontSizeTitle,
        fontSizeText,
        childAspectRatioGrid,
        mainAxisSpacingGrid,
        crossAxisSpacingGrid;
    int crossAxisCountGrid;

    switch (screenSize) {
      case ScreenSize.small:
        fontSizeTitle = 10;
        fontSizeText = 12;
        childAspectRatioGrid = 3.5;
        mainAxisSpacingGrid = 1;
        crossAxisSpacingGrid = 1;
        crossAxisCountGrid = 3;
        break;
      case ScreenSize.medium:
        fontSizeTitle = 13;
        fontSizeText = 16;
        childAspectRatioGrid = 3;
        mainAxisSpacingGrid = 3;
        crossAxisSpacingGrid = 2;
        crossAxisCountGrid = 3;
        break;
      case ScreenSize.large:
        fontSizeTitle = 15;
        fontSizeText = 18;
        childAspectRatioGrid = 4;
        mainAxisSpacingGrid = 10;
        crossAxisSpacingGrid = 10;
        crossAxisCountGrid = 6;
        break;
    }

    // Bright green from your palette
    final Color deleteColor = Color(0xFF8B5500);
    // Replace idCyclePlacette value by with NumCycle value
    if (widget.simpleElements.containsKey('idCyclePlacette')) {
      int? numCyclePlacette = widget.mapNumCyclePlacetteNumCycle[
          widget.simpleElements.getValue('idCyclePlacette')!];
      if (numCyclePlacette != null) {
        widget.simpleElements.setValue('idCyclePlacette', numCyclePlacette);
      }
    }

    // remove the elements of simpleElements that are not in the displayable columns
    widget.simpleElements.removeWhere((element) =>
        !shouldIncludeColumn(element.key, widget.displayTypeState));

    // Map for title name changes
    List<String> titleNames = _getTitleGridNamesForType(
        widget.simpleElements.map((e) => e.key).toList(),
        widget.displayTypeState);

    List<Widget> simpleWidgets = [];
    for (int i = 0; i < widget.simpleElements.length; i++) {
      MapEntry<String, dynamic> entry = widget.simpleElements.entries[i];
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
          padding: EdgeInsets.all(1.0),
          child: Column(
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
          ),
        ),
      );
    }

    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 20,
                left: 10,
              ), // Adjust padding to ensure grid content isn't overlapped by icons
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount:
                    crossAxisCountGrid, // Adjusting the number of columns based on the screen width
                childAspectRatio: childAspectRatioGrid,
                mainAxisSpacing: mainAxisSpacingGrid,
                crossAxisSpacing: crossAxisSpacingGrid,
                children: simpleWidgets,
              ),
            ),
            Positioned(
                right: 0, // Position icons to the top right corner
                top: 0,
                child: ExpandingFAB(
                  distance: 46.0,
                  heroTag: "primaryGridHeroTag",
                  children: [
                    ActionButton(
                      icon: Icon(Icons.delete, color: deleteColor),
                      onPressed: () => {
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
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: const Text('Supprimer',
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    widget.onItemDeleted(widget.simpleElements);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      },
                    ),
                    if (widget.displayTypeState != 'Arbres' &&
                        widget.displayTypeState != 'BmsSup30')
                      ActionButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: () =>
                            widget.onItemUpdated(widget.simpleElements),
                        // iconSize: 18, // Keep the icon size small to save space
                        // padding: const EdgeInsets.all(4),
                        // constraints: BoxConstraints(),
                      ),
                  ],
                )),
          ],
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
        throw ArgumentError('Unknown type: $type');
    }
  }
}
