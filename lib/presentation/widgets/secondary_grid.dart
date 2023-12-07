import 'package:flutter/material.dart';

class SecondaryGrid extends StatefulWidget {
  final List<dynamic> mesuresList;
  final Function(int) onItemSelected;
  final Function(dynamic) onItemMesureAdded;
  final Function(dynamic) onItemMesureDeleted;
  final Function(dynamic) onItemMesureUpdated;
  final int currentIndex;

  SecondaryGrid({
    Key? key,
    required this.mesuresList,
    required this.onItemSelected,
    required this.onItemMesureAdded,
    required this.onItemMesureDeleted,
    required this.onItemMesureUpdated,
    required this.currentIndex,
  }) : super(key: key);

  @override
  _SecondaryGridState createState() => _SecondaryGridState();
}

class _SecondaryGridState extends State<SecondaryGrid> {
  int currentIndex = 0;

  void _showNextItem() {
    if (currentIndex < widget.mesuresList.length - 1) {
      setState(() {
        currentIndex++;
        widget.onItemSelected(currentIndex);
      });
    }
  }

  void _showPreviousItem() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        widget.onItemSelected(currentIndex);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.currentIndex;
    if (widget.mesuresList.isEmpty) {
      return SizedBox.shrink(); // Return an empty widget if the list is empty
    }

    Map<String, dynamic> currentItem = widget.mesuresList[currentIndex];

    List<Widget> gridItems = currentItem.entries.map((entry) {
      return Container(
        padding: const EdgeInsets.all(1.0),
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
                style: TextStyle(fontSize: 12),
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
              onPressed: () {
                widget.onItemMesureUpdated(widget.mesuresList[currentIndex]);
              },
              iconSize: 18, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                widget.onItemMesureDeleted(widget.mesuresList[currentIndex]);
              },
              iconSize: 18, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.green),
              onPressed: () {
                widget.onItemMesureAdded(widget.mesuresList[currentIndex]);
              },
              iconSize: 18, // Reduced icon size
              padding: EdgeInsets.all(4), // Reduced padding
              constraints: BoxConstraints(),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              constraints: BoxConstraints(),
              icon: Icon(Icons.arrow_left, size: 20),
              onPressed: currentIndex > 0
                  ? _showPreviousItem
                  : null, // Disable if first item
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  childAspectRatio: 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 2,
                  children: gridItems,
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              constraints: BoxConstraints(),
              icon: Icon(Icons.arrow_right, size: 20),
              onPressed: currentIndex < widget.mesuresList.length - 1
                  ? _showNextItem
                  : null, // Disable if last item
            ),
          ],
        ),
      ],
    );
  }
}
