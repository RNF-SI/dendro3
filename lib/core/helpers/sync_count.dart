class SyncCounts {
  final int corCyclesPlacettesCreated;
  final int corCyclesPlacettesUpdated;
  final int regenerationsCreated;
  final int regenerationsUpdated;
  final int transectsCreated;
  final int transectsUpdated;
  final int arbresCreated;
  final int arbresUpdated;
  final int arbresMesuresCreated;
  final int arbresMesuresUpdated;
  final int bmsSup30Created;
  final int bmsSup30Updated;
  final int bmSup30MesuresCreated;
  final int bmSup30MesuresUpdated;
  final int reperesCreated;
  final int reperesUpdated;

  SyncCounts({
    required this.corCyclesPlacettesCreated,
    required this.corCyclesPlacettesUpdated,
    required this.regenerationsCreated,
    required this.regenerationsUpdated,
    required this.transectsCreated,
    required this.transectsUpdated,
    required this.arbresCreated,
    required this.arbresUpdated,
    required this.arbresMesuresCreated,
    required this.arbresMesuresUpdated,
    required this.bmsSup30Created,
    required this.bmsSup30Updated,
    required this.bmSup30MesuresCreated,
    required this.bmSup30MesuresUpdated,
    required this.reperesCreated,
    required this.reperesUpdated,
  });

  factory SyncCounts.fromJson(Map<String, dynamic> json) {
    return SyncCounts(
      corCyclesPlacettesCreated: json['corCyclesPlacettes']['created'],
      corCyclesPlacettesUpdated: json['corCyclesPlacettes']['updated'],
      regenerationsCreated: json['regenerations']['created'],
      regenerationsUpdated: json['regenerations']['updated'],
      transectsCreated: json['transects']['created'],
      transectsUpdated: json['transects']['updated'],
      arbresCreated: json['arbres']['created'],
      arbresUpdated: json['arbres']['updated'],
      arbresMesuresCreated: json['arbres_mesures']['created'],
      arbresMesuresUpdated: json['arbres_mesures']['updated'],
      bmsSup30Created: json['bmsSup30']['created'],
      bmsSup30Updated: json['bmsSup30']['updated'],
      bmSup30MesuresCreated: json['bm_sup_30_mesures']['created'],
      bmSup30MesuresUpdated: json['bm_sup_30_mesures']['updated'],
      reperesCreated: json['reperes']['created'],
      reperesUpdated: json['reperes']['updated'],
    );
  }

  SyncCounts.empty()
      : corCyclesPlacettesCreated = 0,
        corCyclesPlacettesUpdated = 0,
        regenerationsCreated = 0,
        regenerationsUpdated = 0,
        transectsCreated = 0,
        transectsUpdated = 0,
        arbresCreated = 0,
        arbresUpdated = 0,
        arbresMesuresCreated = 0,
        arbresMesuresUpdated = 0,
        bmsSup30Created = 0,
        bmsSup30Updated = 0,
        bmSup30MesuresCreated = 0,
        bmSup30MesuresUpdated = 0,
        reperesCreated = 0,
        reperesUpdated = 0;
}
