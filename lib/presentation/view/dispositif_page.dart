import 'package:dendro3/domain/model/cycle.dart';
import 'package:dendro3/domain/model/cycle_list.dart';
import 'package:dendro3/domain/model/dispositif.dart';
import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/model/dispositifInfo.dart';
import 'package:dendro3/presentation/view/placette_page.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
            placette: placetteList[index], cycleList: cycleList);
      },
    );
  }
}

class PlacetteItemCardWidget extends ConsumerWidget {
  const PlacetteItemCardWidget({
    Key? key,
    required this.placette,
    required this.cycleList,
  }) : super(key: key);

  final Placette placette;
  final CycleList cycleList;

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
                          TextSpan(
                            text: "Placette ${placette.idPlacetteOrig}",
                          ),
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
                width: 20,
                child: Row(
                  children: placette.corCyclesPlacettes!.values
                      .map<Widget>(
                        (data) => CircleAvatar(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          radius: 10,
                          child: Text(cycleList.values
                              .firstWhere((Cycle cycle) =>
                                  cycle.idCycle == data.idCycle)
                              .numCycle
                              .toString()),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(
                width: 76,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return PlacettePage(
                          placette: placette,
                          dispCycleList: cycleList,
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

class ChiffresWidget extends StatefulWidget {
  const ChiffresWidget({
    Key? key,
    required this.cycleList,
  }) : super(key: key);

  final CycleList? cycleList;

  @override
  State<StatefulWidget> createState() => _ChiffresWidgetState();
}

class _ChiffresWidgetState extends State<ChiffresWidget> {
  _ChiffresWidgetState();

  late List<bool> cycleSelected;

  @override
  void initState() {
    cycleSelected = widget.cycleList!.values
        .map<bool>((Cycle data) => data.numCycle == 1 ? true : false)
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ToggleButtons(
        isSelected: cycleSelected,
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < cycleSelected.length; i++) {
              cycleSelected[i] = i == index;
            }
          });
        },
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        selectedBorderColor: Colors.blue[700],
        selectedColor: Colors.white,
        fillColor: Colors.blue[200],
        color: Colors.blue[400],
        constraints: const BoxConstraints(
          minHeight: 40.0,
          minWidth: 80.0,
        ),
        children: <Widget>[
          ..._generateCircleAvatars(widget.cycleList!),
        ],
      ),
      ...__buildGridText(
        widget.cycleList![
            cycleSelected.indexWhere((selected) => selected == true)],
      ),
    ]);
  }
}

List<Widget> _generateCircleAvatars(CycleList cycleList) {
  var list = cycleList.values
      .map<Widget>((data) => CircleAvatar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            radius: 10,
            child: Text(
              data.numCycle.toString(),
            ),
          ))
      .toList();
  return list;
}

List<Widget> __buildGridText(Cycle cycle) {
  return [
    SizedBox(
      height: 200.0,
      child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          childAspectRatio: (1 / .2),
          children: [
            __buildPropertyTextWidget('idCycle', cycle.idCycle),
            __buildPropertyTextWidget('idDispositif', cycle.idDispositif),
            __buildPropertyTextWidget('numCycle', cycle.numCycle),
            __buildPropertyTextWidget('coeff', cycle.coeff),
            __buildPropertyTextWidget(
                'dateDebut',
                cycle.dateDebut != null
                    ? '${cycle.dateDebut!.day}/${cycle.dateDebut!.month}/${cycle.dateDebut!.year}'
                    : null),
            __buildPropertyTextWidget(
                'dateFin',
                cycle.dateFin != null
                    ? '${cycle.dateFin!.day}/${cycle.dateFin!.month}/${cycle.dateFin!.year}'
                    : null),
            __buildPropertyTextWidget('diamLim', cycle.diamLim),
            __buildPropertyTextWidget('monitor', cycle.monitor),
          ]),
    ),
    Tooltip(
      message: "Calculé en fonction de DateFin.\n"
          "Avertissez le responsable PSDRF \npour actualiser.",
      triggerMode: TooltipTriggerMode.tap,
      child: cycle.dateFin == null
          ? const Text("Ce cycle est en cours")
          : const Text("Ce cycle est terminé"),
    )
  ];
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
