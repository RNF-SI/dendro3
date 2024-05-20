class ExportDetails {
  final int created;
  final int updated;
  final int deleted;

  ExportDetails(
      {required this.created, required this.updated, required this.deleted});
}

class ExportResults {
  final ExportDetails localArbres;
  final ExportDetails distantArbres;
  final ExportDetails localArbresMesures;
  final ExportDetails distantArbresMesures;
  final ExportDetails localBms;
  final ExportDetails distantBms;
  final ExportDetails localBmsMesures;
  final ExportDetails distantBmsMesures;
  final ExportDetails localReperes;
  final ExportDetails distantReperes;
  final ExportDetails localCorCyclesPlacettes;
  final ExportDetails distantCorCyclesPlacettes;
  final ExportDetails localRegenerations;
  final ExportDetails distantRegenerations;
  final ExportDetails localTransects;
  final ExportDetails distantTransects;

  // Add other entities as necessary

  ExportResults({
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

  // create an empty ExportResult to debug
  ExportResults.empty()
      : localArbres = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantArbres = ExportDetails(created: 0, updated: 0, deleted: 0),
        localArbresMesures = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantArbresMesures =
            ExportDetails(created: 0, updated: 0, deleted: 0),
        localBms = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantBms = ExportDetails(created: 0, updated: 0, deleted: 0),
        localBmsMesures = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantBmsMesures = ExportDetails(created: 0, updated: 0, deleted: 0),
        localReperes = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantReperes = ExportDetails(created: 0, updated: 0, deleted: 0),
        localCorCyclesPlacettes =
            ExportDetails(created: 0, updated: 0, deleted: 0),
        distantCorCyclesPlacettes =
            ExportDetails(created: 0, updated: 0, deleted: 0),
        localRegenerations = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantRegenerations =
            ExportDetails(created: 0, updated: 0, deleted: 0),
        localTransects = ExportDetails(created: 0, updated: 0, deleted: 0),
        distantTransects = ExportDetails(created: 0, updated: 0, deleted: 0);
}

class TaskResult {
  final ExportResults exportResults;
  final List<Map<String, dynamic>> createdArbres;
  final List<Map<String, dynamic>> createdBms;

  TaskResult({
    required this.exportResults,
    required this.createdArbres,
    required this.createdBms,
  });
}
