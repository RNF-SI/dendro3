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
  });
}
