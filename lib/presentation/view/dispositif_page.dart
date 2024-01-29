import 'package:dendro3/domain/model/corCyclePlacette.dart';
import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/view/placette_page/placette_page.dart';
import 'package:dendro3/presentation/viewmodel/corCyclePlacetteList/cor_cycle_placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/last_selected_Id_notifier.dart';
import 'package:dendro3/presentation/widgets/chiffres_widget.dart';
import 'package:dendro3/presentation/widgets/placette_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;
import 'package:dendro3/presentation/lib/utils.dart';

class DispositifPage extends ConsumerWidget {
  DispositifPage({
    Key? key,
    required this.dispInfo,
  })  : dispositifId = dispInfo.dispositif.id,
        dispositifName = dispInfo.dispositif.name,
        super(key: key);

  late final DispositifViewModel _viewModel;
  final DispositifInfo dispInfo;
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
                  case 'start_new_cycle':
                    return showNewCycleDialog(context, ref, dispositifId);
                  case 'open_remove_dialog':
                    return showAlertDialog(
                        context, ref, dispInfo, dispositifId, dispositifName);
                  default:
                    throw UnimplementedError();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'start_new_cycle',
                  child: Row(
                    children: const [
                      Icon(Icons.onetwothree, color: Colors.green),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text(
                        "Commencer un nouveau cycle",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'open_remove_dialog',
                  child: Row(
                    children: const [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text(
                        "Supprimer localement",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                // popupmenu item 2
              ],
              offset: const Offset(0, 50),
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
          children: __buildAsyncPages(context, ref, dispositifId),
          // [
          //   __buildAsyncPlacetteListWidget(context, ref, dispositifId),
          //   __buildAsyncCycleInfoWidget(context, ref, dispositifId),
          // ],
        ),
      ),
    );
  }
}

showAlertDialog(
  BuildContext context,
  WidgetRef ref,
  DispositifInfo dispositifInfo,
  int dispositifId,
  String dispositifName,
) {
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
          .deleteDispositif(
              context,
              () => {
                    Navigator.of(context).pop(),
                    Navigator.of(context).pop(),
                  },
              dispositifInfo);
      // context.go("/home");
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Attention"),
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

showNewCycleDialog(
  BuildContext context,
  WidgetRef ref,
  int dispositifId,
) {
  // set up the buttons
  Widget comprisButton = TextButton(
    child: const Text("Compris"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget actualiserButton = TextButton(
    child: const Text("Actualiser les cycles"),
    onPressed: () async {
      await ref
          .read(dispositifViewModelProvider(dispositifId).notifier)
          .actualiserCyclesDispositif(
              context, () => {Navigator.of(context).pop()}, dispositifId);
      // context.go("/home");
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Information"),
    content: RichText(
      text: const TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Pour commencer un nouveau cycle il faut d'abord en informer"
                " le responsable PSDRF à RNF. Vous pouvez ensuite importer le nouveau cycle"
                " depuis la base de données distante en cliquant sur 'Actualiser les cycles'.",
          ),
        ],
      ),
    ),
    actions: [
      comprisButton,
      actualiserButton,
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

List<Widget> __buildAsyncPages(
  final BuildContext context,
  WidgetRef ref,
  int dispositifId,
) {
  final _viewModel = ref.watch(dispositifViewModelProvider(dispositifId));

  return [
    __buildAsyncPlacetteListWidget(context, ref, _viewModel),
    __buildAsyncCycleInfoWidget(context, ref, _viewModel),
  ];
}

Widget __buildAsyncPlacetteListWidget(
  final BuildContext context,
  WidgetRef ref,
  custom_async_state.State<Dispositif> stateDisp,
) {
  return stateDisp.maybeWhen(
    success: (data) =>
        _buildPlacetteListWidget(context, data.placettes!, data.cycles!),
    error: (_) => const Center(
      child: Text('Uh oh... Something went wrong...',
          style: TextStyle(color: Colors.white)),
    ),
    orElse: () => const Center(child: CircularProgressIndicator()),
  );
}

Widget _buildPlacetteListWidget(
  final BuildContext context,
  final PlacetteList placetteList,
  final CycleList cycleList,
) {
  if (placetteList.length == 0) {
    return const Center(child: Text('Pas de Placette'));
  } else {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: placetteList.length,
      shrinkWrap: true,
      itemBuilder: (final BuildContext context, final int index) {
        return PlacetteItemCardWidget(
          placette: placetteList[index],
          cycleList: cycleList,
        );
      },
    );
  }
}

Widget __buildAsyncCycleInfoWidget(
  final BuildContext context,
  WidgetRef ref,
  custom_async_state.State<Dispositif> stateDisp,
) {
  return stateDisp.maybeWhen(
    success: (data) => ChiffresWidget(cycleList: data.cycles),
    error: (_) => const Center(
      child: Text('Uh oh... Something went wrong...',
          style: TextStyle(color: Colors.white)),
    ),
    orElse: () => const Center(child: CircularProgressIndicator()),
  );
}
