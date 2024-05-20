import 'package:dendro3/core/helpers/export_objects.dart';
import 'package:dendro3/core/helpers/sync_count.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/sync_state_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncResultsWidget extends ConsumerWidget {
  final int dispositifId;

  SyncResultsWidget({required this.dispositifId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncStateProvider(dispositifId));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Synchronization"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.publish), text: 'Export'),
              Tab(icon: Icon(Icons.download), text: 'Import'),
            ],
          ),
        ),
        body: syncState.isLoading
            ? Center(child: CircularProgressIndicator())
            : syncState.error != null
                ? Text("Error: ${syncState.error}")
                : TabBarView(
                    children: [
                      _buildSyncResults(context, syncState),
                      _buildSyncSummary(context, syncState),
                    ],
                  ),
      ),
    );
  }

  Widget _buildSyncResults(BuildContext context, SyncState state) {
    if (state.results == null) {
      return Text("No synchronization data available.");
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildListSections(state.results!),
          ],
        ),
      );
    }
  }

  Widget _buildSyncSummary(BuildContext context, SyncState state) {
    if (state.counts == null) {
      return Text("Pas de données de synchros valides.");
    } else {
      return ListView(
        children: _buildCountsView(state.counts!),
      );
    }
  }

  List<Widget> _buildListSections(ExportResults results) {
    List<Widget> sections = [];
    // Example for one section, repeat for others
    // Section for CorCyclePlacettes
    sections.add(_buildSection(
      "CorCyclePlacettes",
      results.distantCorCyclesPlacettes,
      Icons.location_on, // Icon suggestive of specific locations (placettes)
    ));
    // Section for Distant Arbres
    sections.add(_buildSection(
      "Arbres",
      results.distantArbres,
      Icons.park,
    ));

    // Section for Arbres Mesures
    sections.add(_buildSection(
      "Arbres Mesures",
      results.distantArbresMesures,
      Icons.onetwothree, // Icon suggestive of a tree measured periodically
    ));

    // Section for Bms
    sections.add(_buildSection(
      "Bms",
      results.distantBms,
      Icons.compost, // Icon suggestive of dead wood in a forest
    ));

    // Section for Bms Mesures
    sections.add(_buildSection(
      "Bms Mesures",
      results.distantBmsMesures,
      Icons.onetwothree, // Icon suggestive of measured data for dead wood
    ));

    // Section for Transects
    sections.add(_buildSection(
      "Transects",
      results.distantTransects,
      Icons.linear_scale, // Icon suggestive of measurements of small dead wood
    ));
    sections.add(_buildSection(
      "Regenerations",
      results.distantRegenerations,
      Icons.child_care, // Icon suggestive of measurements of small dead wood
    ));
    // Section for Reperes
    sections.add(_buildSection(
      "Reperes",
      results.distantReperes,
      Icons.visibility, // Icon suggestive of observations
    ));
    // Add other sections similarly
    return sections;
  }

  Widget _buildSection(String title, ExportDetails data, IconData icon) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      leading: Icon(icon),
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.add_circle_outline, color: Colors.green),
          title: Text("Created: ${data.created}"),
        ),
        ListTile(
          leading: Icon(Icons.update, color: Colors.amber),
          title: Text("Updated: ${data.updated}"),
        ),
        ListTile(
          leading: Icon(Icons.delete_outline, color: Colors.red),
          title: Text("Deleted: ${data.deleted}"),
        ),
      ],
    );
  }

  List<Widget> _buildCountsView(SyncCounts counts) {
    return [
      ListTile(
        title: Text("Sync Summary"),
        subtitle: Text(
            "CorCyclePlacettes: Created ${counts.corCyclesPlacettesCreated}, Updated ${counts.corCyclesPlacettesUpdated}\n"
            "Arbres: Created ${counts.arbresCreated}, Updated ${counts.arbresUpdated}\n"
            "Arbres Mesures: Created ${counts.arbresMesuresCreated}, Updated ${counts.arbresMesuresUpdated}\n"
            "Bms: Created ${counts.bmsSup30Created}, Updated ${counts.bmsSup30Updated}\n"
            "Bms Mesures: Created ${counts.bmSup30MesuresCreated}, Updated ${counts.bmSup30MesuresUpdated}\n"
            "Reperes: Created ${counts.reperesCreated}, Updated ${counts.reperesUpdated}"
            "Regenerations: Created ${counts.regenerationsCreated}, Updated ${counts.regenerationsUpdated}\n"
            "Transects: Created ${counts.transectsCreated}, Updated ${counts.transectsUpdated}\n"),
      ),
    ];
  }
}
