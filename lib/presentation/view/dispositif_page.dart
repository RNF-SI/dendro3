import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/view/placette_list_widget.dart';
import 'package:dendro3/presentation/view/sync_result.dart';
import 'package:dendro3/presentation/viewmodel/baseList/placette_list_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:dendro3/presentation/widgets/chiffres_widget.dart';
import 'package:dendro3/presentation/widgets/placette_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dendro3/presentation/state/state.dart' as custom_async_state;

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
          title: Text('Dispositif $dispositifId: $dispositifName',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) async {
                switch (value) {
                  case 'export_disp':
                    showSyncResultsDialog(context, dispositifId);
                    break;
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
                  value: 'export_disp',
                  child: menuItemRow(Icons.cloud_upload,
                      "Exporter le dispositif", Color(0xFF7DAB9C)),
                ),
                PopupMenuItem(
                  value: 'start_new_cycle',
                  child: menuItemRow(Icons.onetwothree,
                      "Commencer un nouveau cycle", Color(0xFF8AAC3E)),
                ),
                PopupMenuItem(
                  value: 'open_remove_dialog',
                  child: menuItemRow(
                      Icons.delete, "Supprimer localement", Colors.red),
                ),
              ],
              offset: Offset(0, 50),
              color: Colors.white,
              elevation: 2,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.radio_button_checked), text: 'Placettes'),
              Tab(icon: Icon(Icons.insights), text: 'Chiffres'),
            ],
            indicatorColor: Color(0xFF8AAC3E),
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

Widget menuItemRow(IconData icon, String text, Color textColor) {
  return Row(
    children: [
      Icon(icon, color: textColor),
      SizedBox(width: 10),
      Text(text, style: TextStyle(color: textColor)),
    ],
  );
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
    title: const Text(
      "Attention",
      style: TextStyle(color: Color(0xFF1a1a18)),
    ),
    content: RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFF1a1a18),
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

void showSyncResultsDialog(BuildContext context, int dispositifId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: 300,
          height: 500, // Adjust the size as needed
          child: SyncResultsWidget(dispositifId: dispositifId),
        ),
      );
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
              context, () => Navigator.of(context).pop(), dispositifId);
      // context.go("/home");
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title:
        const Text("Information", style: TextStyle(color: Color(0xFF1a1a18))),
    content: RichText(
      text: const TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF1a1a18),
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
  final viewModel = ref.watch(dispositifViewModelProvider(dispositifId));
  return [
    __buildAsyncPlacetteListWidget(context, ref, viewModel),
    __buildAsyncCycleInfoWidget(context, ref, viewModel),
  ];
}

Widget __buildAsyncPlacetteListWidget(
  final BuildContext context,
  WidgetRef ref,
  custom_async_state.State<Dispositif> stateDisp,
  // PlacetteListViewModel vm,
) {
  return stateDisp.maybeWhen(
    success: (data) {
      return PlacetteListWidget(
        cycleList: data.cycles!,
      );
    },
    error: (_) => const Center(
      child: Text('Uh oh... Something went wrong...',
          style: TextStyle(color: Colors.white)),
    ),
    orElse: () => const Center(child: CircularProgressIndicator()),
  );
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
