import 'package:dendro3/domain/model/placette.dart';
import 'package:dendro3/domain/model/placette_list.dart';
import 'package:dendro3/presentation/view/saisie_placette_page.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/dispositif_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

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
          title: Text('Placette ${placette.idPlacetteOrig}'),
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
        floatingActionButton: PlacetteFAB(
          distance: 112.0,
          children: [
            ActionButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return SaisiePlacettePage(placette: placette);
                },
              )),
              icon: const Icon(Icons.add),
            ),
            ActionButton(
              onPressed: () => null,
              icon: const Icon(Icons.play_arrow),
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

@immutable
class PlacetteFAB extends ConsumerStatefulWidget {
  const PlacetteFAB({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  PlacetteFABState createState() => PlacetteFABState();
}

class PlacetteFABState extends ConsumerState<PlacetteFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double>? _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation!,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.create),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.secondary,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}
