import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PlacettePage extends ConsumerWidget {
  PlacettePage({Key? key, required this.placette}) : super(key: key);

  Placette placette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Placette {$placette.idPlacette}'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'open_remove_dialog':
                  // return showAlertDialog(
                  //     context, ref, dispositifId, dispositifName);
                  default:
                    throw UnimplementedError();
                }
              },
              itemBuilder: (context) => [
                // popupmenu item 1
                // PopupMenuItem(
                // value: 'open_remove_dialog',
                // child: Row(
                //   children: const [
                //     Icon(Icons.delete, color: Colors.red),
                //     SizedBox(
                //       // sized box with width 10
                //       width: 10,
                //     ),
                //     Text("Supprimer localement",
                //         style: TextStyle(color: Colors.red))
                //   ],
                // ),
                // ),
                // popupmenu item 2
              ],
              offset: Offset(0, 50),
              color: Colors.white,
              elevation: 2,
            ),
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.summarize),
                text: 'Résumé',
              ),
              Tab(icon: Icon(Icons.onetwothree), text: 'Cycles'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            __buildPlacetteResumeWidget(context, ref, placette),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget __buildPlacetteResumeWidget(
    final BuildContext context, final WidgetRef ref, final Placette placette) {
  return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      childAspectRatio: (1 / .2),
      children: [
        __buildPropertyTextWidget('idPlacette', placette.idPlacette),
        __buildPropertyTextWidget('idDispositif', placette.idDispositif),
        __buildPropertyTextWidget('idPlacetteOrig', placette.idPlacetteOrig),
        __buildPropertyTextWidget('strate', placette.strate),
        __buildPropertyTextWidget('pente', placette.pente),
        __buildPropertyTextWidget('poidsPlacette', placette.poidsPlacette),
        __buildPropertyTextWidget('correctionPente', placette.correctionPente),
        __buildPropertyTextWidget('exposition', placette.exposition),
        __buildPropertyTextWidget('profondeurApp', placette.profondeurApp),
        __buildPropertyTextWidget('profondeurHydr', placette.profondeurHydr),
        __buildPropertyTextWidget('texture', placette.texture),
        __buildPropertyTextWidget('habitat', placette.habitat),
        __buildPropertyTextWidget('station', placette.station),
        __buildPropertyTextWidget('typologie', placette.typologie),
        __buildPropertyTextWidget('groupe', placette.groupe),
        __buildPropertyTextWidget('groupe1', placette.groupe1),
        __buildPropertyTextWidget('groupe2', placette.groupe2),
        __buildPropertyTextWidget('refHabitat', placette.refHabitat),
        __buildPropertyTextWidget(
            'precisionHabitat', placette.precisionHabitat),
        __buildPropertyTextWidget('refStation', placette.refStation),
        __buildPropertyTextWidget('refTypologie', placette.refTypologie),
        __buildPropertyTextWidget(
            'descriptifGroupe', placette.descriptifGroupe),
        __buildPropertyTextWidget(
            'descriptifGroupe1', placette.descriptifGroupe1),
        __buildPropertyTextWidget(
            'descriptifGroupe2', placette.descriptifGroupe2),
        __buildPropertyTextWidget('precisionGps', placette.precisionGps),
        __buildPropertyTextWidget('cheminement', placette.cheminement)
      ]);
}

Widget __buildPropertyTextWidget(String property, dynamic value) {
  return Center(
    child: RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 10.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: "$property :"),
          TextSpan(
            text: value.toString(),
            style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
