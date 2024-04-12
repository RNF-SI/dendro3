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
  final SyncDetails localBms;
  final SyncDetails distantBms;
  // Add other entities as necessary

  SyncResults({
    required this.localArbres,
    required this.distantArbres,
    required this.localBms,
    required this.distantBms,
    // Initialize other entities here
  });
}
