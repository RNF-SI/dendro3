import 'package:flutter/material.dart';

Widget createPrimaryGrid(List<MapEntry<String, dynamic>> simpleElements) {
  List<Widget> simpleWidgets =
      simpleElements.map((MapEntry<String, dynamic> entry) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${entry.key}:",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            entry.value.toString(),
            style: TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }).toList();

  return GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 4,
    childAspectRatio: 3,
    children: simpleWidgets,
  );
}

class SecondaryGrid extends StatefulWidget {
  final List<dynamic> arbresMesuresList;

  SecondaryGrid({Key? key, required this.arbresMesuresList}) : super(key: key);

  @override
  _SecondaryGridState createState() => _SecondaryGridState();
}

class _SecondaryGridState extends State<SecondaryGrid> {
  int currentIndex = 0;

  void _showNextItem() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.arbresMesuresList.length;
    });
  }

  void _showPreviousItem() {
    setState(() {
      currentIndex = (currentIndex - 1 + widget.arbresMesuresList.length) %
          widget.arbresMesuresList.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.arbresMesuresList.isEmpty) {
      return SizedBox.shrink(); // Return an empty widget if the list is empty
    }

    // Assuming each item in arbresMesuresList is a Map<String, dynamic>
    Map<String, dynamic> currentItem = widget.arbresMesuresList[currentIndex];

    List<Widget> gridItems = currentItem.entries.map((entry) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${entry.key}:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              entry.value.toString(),
              style: TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    }).toList();

    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_left),
              onPressed: _showPreviousItem,
            ),
            Expanded(
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 3,
                children: gridItems,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_right),
              onPressed: _showNextItem,
            ),
          ],
        ),
      ],
    );
  }
}
