class SyncDetails {
  final int created;
  final int updated;
  final int deleted;

  SyncDetails(
      {required this.created, required this.updated, required this.deleted});
}

class SyncResults {
  final SyncDetails localArbres;
  final SyncDetails distantArbres;
  final SyncDetails localArbresMesures;
  final SyncDetails distantArbresMesures;
  final SyncDetails localBms;
  final SyncDetails distantBms;
  final SyncDetails localBmsMesures;
  final SyncDetails distantBmsMesures;
  final SyncDetails localReperes;
  final SyncDetails distantReperes;
  final SyncDetails localCorCyclesPlacettes;
  final SyncDetails distantCorCyclesPlacettes;
  final SyncDetails localRegenerations;
  final SyncDetails distantRegenerations;
  final SyncDetails localTransects;
  final SyncDetails distantTransects;

  // Add other entities as necessary

  SyncResults({
    required this.localArbres,
    required this.distantArbres,
    required this.localArbresMesures,
    required this.distantArbresMesures,
    required this.localBms,
    required this.distantBms,
    required this.localBmsMesures,
    required this.distantBmsMesures,
    required this.localReperes,
    required this.distantReperes,
    required this.localCorCyclesPlacettes,
    required this.distantCorCyclesPlacettes,
    required this.localRegenerations,
    required this.distantRegenerations,
    required this.localTransects,
    required this.distantTransects,
  });
}

class TaskResult {
  final SyncResults syncResults;
  final List<Map<String, dynamic>> createdArbres;
  final List<Map<String, dynamic>> createdBms;

  TaskResult({
    required this.syncResults,
    required this.createdArbres,
    required this.createdBms,
  });
}
