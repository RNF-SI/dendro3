import 'package:dendro3/core/helpers/sync_objects.dart';
import 'package:dendro3/presentation/viewmodel/dispositif/sync_state_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SyncResultsWidget extends ConsumerWidget {
  final int dispositifId;

  SyncResultsWidget({required this.dispositifId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncState = ref.watch(syncStateProvider(dispositifId));

    return Scaffold(
      appBar: AppBar(title: Text("Synchronisation")),
      body: syncState.isLoading
          ? Center(child: CircularProgressIndicator())
          : syncState.error != null
              ? Text("Error: ${syncState.error}")
              : _buildSyncResults(syncState.results),
    );
  }

  Widget _buildSyncResults(SyncResults? results) {
    if (results == null) {
      return Text("No synchronization data available.");
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Local Arbres:"),
            // Text("  Created: ${results.localArbres.created}"),
            // Text("  Updated: ${results.localArbres.updated}"),
            // Text("  Deleted: ${results.localArbres.deleted}"),
            // Divider(),
            Text("Distant Arbres:"),
            Text("  Created: ${results.distantArbres.created}"),
            Text("  Updated: ${results.distantArbres.updated}"),
            Text("  Deleted: ${results.distantArbres.deleted}"),
            Divider(),
            // Text("Local Arbres Mesures:"),
            // Text("  Created: ${results.localArbresMesures.created}"),
            // Text("  Updated: ${results.localArbresMesures.updated}"),
            // Text("  Deleted: ${results.localArbresMesures.deleted}"),
            // Divider(),
            Text("Distant Arbres Mesures:"),
            Text("  Created: ${results.distantArbresMesures.created}"),
            Text("  Updated: ${results.distantArbresMesures.updated}"),
            Text("  Deleted: ${results.distantArbresMesures.deleted}"),
            Divider(),
            // Text("Local Bms:"),
            // Text("  Created: ${results.localBms.created}"),
            // Text("  Updated: ${results.localBms.updated}"),
            // Text("  Deleted: ${results.localBms.deleted}"),
            // Divider(),
            Text("Distant Bms:"),
            Text("  Created: ${results.distantBms.created}"),
            Text("  Updated: ${results.distantBms.updated}"),
            Text("  Deleted: ${results.distantBms.deleted}"),
            Divider(),
            // Text("Local Bms Mesures:"),
            // Text("  Created: ${results.localBmsMesures.created}"),
            // Text("  Updated: ${results.localBmsMesures.updated}"),
            // Text("  Deleted: ${results.localBmsMesures.deleted}"),
            // Divider(),
            Text("Distant Bms Mesures:"),
            Text("  Created: ${results.distantBmsMesures.created}"),
            Text("  Updated: ${results.distantBmsMesures.updated}"),
            Text("  Deleted: ${results.distantBmsMesures.deleted}"),
            Divider(),
            Text("Distant Reperes:"),
            Text("  Created: ${results.distantReperes.created}"),
            Text("  Updated: ${results.distantReperes.updated}"),
            Text("  Deleted: ${results.distantReperes.deleted}"),
          ],
        ),
      );
    }
  }
}
