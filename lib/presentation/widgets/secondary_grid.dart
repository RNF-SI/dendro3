import 'package:dendro3/domain/model/arbre.dart';
import 'package:dendro3/domain/model/bmSup30.dart';
import 'package:dendro3/domain/model/regeneration.dart';
import 'package:dendro3/domain/model/repere.dart';
import 'package:dendro3/domain/model/transect.dart';
import 'package:flutter/material.dart';

class SecondaryGrid extends StatefulWidget {
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
        // Check if this is the last item
        if (index == widget.mesuresList.length) {
          // Return the "Add New Measure" element
          return GestureDetector(
            onTap: () {
              // Handle the addition of a new measure here
              widget.onItemMesureAdded(widget.mesuresList[currentIndex]);
            },
            child: Container(
              width: 200, // Same width as other items
              height: 200,
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
        }

        Map<String, dynamic> currentItem = widget.mesuresList[index];

        currentItem = filterMesureItem(currentItem, widget.displayTypeState);

        return Container(
          width: 250,
          height: 150, // Define the width for each item
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
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        widget.onItemMesureDeleted(widget.mesuresList[index]);
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
                      crossAxisCount: 3, // Number of columns in the grid
                      childAspectRatio: 3, // Aspect ratio of each grid cell
                    ),
                    itemCount: currentItem.entries.length,
                    itemBuilder: (context, itemIndex) {
                      var entry = currentItem.entries.elementAt(itemIndex);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "${entry.key}:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10),
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
}
