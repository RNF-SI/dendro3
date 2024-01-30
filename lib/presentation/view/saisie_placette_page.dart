import 'package:dendro3/domain/model/corCyclePlacette_list.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/presentation/viewmodel/placette/saisie_placette_viewmodel.dart';
import 'package:dendro3/presentation/viewmodel/displayable_list_notifier.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/displayable_button.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table.dart';
import 'package:dendro3/presentation/widgets/saisie_data_table/saisie_data_table_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaisiePlacettePage extends ConsumerStatefulWidget {
  SaisiePlacettePage({
    Key? key,
    required this.placette,
    required this.corCyclePlacetteList,
    required this.dispCycleList,
  }) : super(key: key);

  Placette placette;
  CycleList dispCycleList;
  CorCyclePlacetteList corCyclePlacetteList;

  @override
  SaisiePlacettePageState createState() => SaisiePlacettePageState();
}

class SaisiePlacettePageState extends ConsumerState<SaisiePlacettePage> {
  List<String> list = ["Régénération et Transect", "Arbre", "BMS"];
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            title: const Center(
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.forest,
                    color: Colors.green,
                    size: 100,
                  ),
                  Text(
                    "Saisie PSDRF",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            content: SizedBox(
              // Change as per your requirement
              width: 100,
              height: 200,
              child: Column(
                children: [
                  const Text('La saisie PSDRF se fait en 3 étapes'),
                  ListView.builder(
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return SizedBox(
                        height: 50.0,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              radius: 10,
                              child: Text(
                                index.toString(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(list[index]),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: buttonStyle,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Commencer l'étape 1"),
              ),
            ],
            actionsAlignment: MainAxisAlignment.center),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Saisie Placette ${widget.placette.idPlacetteOrig}'),
            const SizedBox(width: 8),
            Text(
              '(DISP ${widget.placette.idDispositif})',
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
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
            itemBuilder: (context) => [],
            offset: const Offset(0, 50),
            color: Colors.white,
            elevation: 2,
          ),
        ],
      ),
      // body: null,
      body: __buildAsyncPlacetteListWidget(
        context,
        ref,
        widget.placette,
        widget.dispCycleList,
        widget.corCyclePlacetteList,
      ),
    );
  }
}

Widget __buildAsyncPlacetteListWidget(
  final BuildContext context,
  WidgetRef ref,
  Placette placette,
  CycleList dispCycleList,
  CorCyclePlacetteList corCyclePlacetteList,
) {
  final viewModel =
      ref.watch(saisiePlacetteViewModelProvider(placette.idPlacette));

  return viewModel.maybeWhen(
    success: (data) {
      final displayableListNotifier =
          ref.watch(displayableListProvider.notifier);
      final displayTypeState = ref.watch(displayTypeStateProvider);

      return Column(
        children: [
          Expanded(
            child: SaisieDataTable(
              placette: placette,
              dispCycleList: dispCycleList,
              corCyclePlacetteList: corCyclePlacetteList,
              displayTypeState: displayTypeState,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DisplayableButton(
                  onPressed: () {
                    ref
                        .read(displayTypeStateProvider.notifier)
                        .update('Arbres');
                    displayableListNotifier.setDisplayableListFromListProvider(
                        ref, 'Arbres');
                  },
                  text: "Arbres",
                ),
                DisplayableButton(
                  onPressed: () {
                    ref
                        .read(displayTypeStateProvider.notifier)
                        .update('BmsSup30');
                    displayableListNotifier.setDisplayableListFromListProvider(
                        ref, 'BmsSup30');
                  },
                  text: "BmsSup30",
                ),
                DisplayableButton(
                  onPressed: () {
                    ref
                        .read(displayTypeStateProvider.notifier)
                        .update('Transects');
                    displayableListNotifier.setDisplayableListFromListProvider(
                        ref, 'Transects');
                  },
                  text: "Transects",
                ),
                DisplayableButton(
                  onPressed: () {
                    ref
                        .read(displayTypeStateProvider.notifier)
                        .update('Regenerations');
                    displayableListNotifier.setDisplayableListFromListProvider(
                        ref, 'Regenerations');
                  },
                  text: 'Regenerations',
                ),
                DisplayableButton(
                  onPressed: () {
                    ref
                        .read(displayTypeStateProvider.notifier)
                        .update('Reperes');
                    displayableListNotifier.setDisplayableListFromListProvider(
                        ref, 'Reperes');
                  },
                  text: "Reperes",
                ),
              ],
            ),
          )
        ],
      );
    },
    error: (_) => const Center(
      child: Text('Uh oh... Something went wrong...',
          style: TextStyle(color: Colors.white)),
    ),
    orElse: () => const Center(child: CircularProgressIndicator()),
  );
}
