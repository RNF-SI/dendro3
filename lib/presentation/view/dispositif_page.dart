import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/view/placette_page.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DispositifPage extends ConsumerWidget {
  DispositifPage(
      {Key? key, required this.dispositifId, required this.dispositifName})
      : super(key: key);

  late final DispositifViewModel _viewModel;
  final int dispositifId;
  final String dispositifName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dispositif $dispositifId: $dispositifName'),
          actions: <Widget>[
            // popup menu button

            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'open_remove_dialog':
                    return showAlertDialog(
                        context, ref, dispositifId, dispositifName);
                  default:
                    throw UnimplementedError();
                }
              },
              itemBuilder: (context) => [
                // popupmenu item 1
                PopupMenuItem(
                  value: 'open_remove_dialog',
                  child: Row(
                    children: const [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Supprimer localement",
                          style: TextStyle(color: Colors.red))
                    ],
                  ),
                ),
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
                icon: Icon(Icons.radio_button_checked),
                text: 'Placettes',
              ),
              Tab(icon: Icon(Icons.insights), text: 'Chiffres'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            __buildAsyncPlacetteListWidget(context, ref, dispositifId),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, WidgetRef ref, int dispositifId,
    String dispositifName) {
  // set up the buttons
  Widget annuleButton = TextButton(
    child: const Text("Annuler"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continuer", style: TextStyle(color: Colors.red)),
    onPressed: () async {
      await ref
          .read(dispositifViewModelProvider(dispositifId).notifier)
          .deleteDispositif(context, () => {context.go("/home")}, dispositifId);
      // context.go("/home");
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Attention"),
    content: RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          const TextSpan(
              text:
                  'Etes vous sûr de vouloir supprimer les données locale du dispositif '),
          TextSpan(
              text: dispositifName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(
              text:
                  '? En faisant ça vous perdrez vos éventuelles modifications en cours'),
        ],
      ),
    ),
    actions: [
      annuleButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget __buildAsyncPlacetteListWidget(
    final BuildContext context, WidgetRef ref, int dispositifId) {
  final _viewModel = ref.watch(dispositifViewModelProvider(dispositifId));

  return _viewModel.maybeWhen(
    success: (data) => _buildPlacetteListWidget(context, data.placettes!),
    error: (_) => const Center(
      child: Text('Uh oh... Something went wrong...',
          style: TextStyle(color: Colors.white)),
    ),
    orElse: () =>
        const Expanded(child: Center(child: CircularProgressIndicator())),
  );
}

Widget _buildPlacetteListWidget(
    final BuildContext context, final PlacetteList placetteList) {
  if (placetteList.length == 0) {
    return const Center(child: Text('Pas de Placette'));
  } else {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: placetteList.length,
      shrinkWrap: true,
      itemBuilder: (final BuildContext context, final int index) {
        return PlacetteItemCardWidget(placette: placetteList[index]);
      },
    );
  }
}

class PlacetteItemCardWidget extends ConsumerWidget {
  const PlacetteItemCardWidget({
    Key? key,
    required this.placette,
  }) : super(key: key);

  final Placette placette;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: "Placette ${placette.idPlacetteOrig}"),
                          TextSpan(
                            text: "(${placette.idPlacette})",
                            style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              SizedBox(
                width: 96,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return PlacettePage(
                          placette: placette,
                        );
                      },
                    ));
                  },
                  icon: const Icon(
                    Icons.visibility,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
