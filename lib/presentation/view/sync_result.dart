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
          ? CircularProgressIndicator()
          : syncState.results != null
              ? Text(
                  "Sync Completed: Added ${syncState.results!.localArbres.created} Arbres")
              : Text("Error: ${syncState.error}"),
    );
  }
}
