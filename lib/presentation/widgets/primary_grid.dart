import 'package:flutter/material.dart';

class PrimaryGridWidget extends StatelessWidget {
  final List<MapEntry<String, dynamic>> simpleElements;
  final Function(dynamic) onItemDeleted;
  final Function(dynamic) onItemUpdated;

  PrimaryGridWidget({
    Key? key,
    required this.simpleElements,
    required this.onItemDeleted,
    required this.onItemUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(Icons.delete),
              onPressed: () =>
                  onItemDeleted(simpleElements), // Using onItemMesureDeleted
              iconSize: 18, // Reduced icon size
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
}
