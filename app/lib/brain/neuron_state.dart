class NeuronState {
  // ==========================================================
  // ATTIVAZIONE
  // ==========================================================

  /// Attivazione istantanea del neurone (0.0 - 1.0)
  double activation;

  /// Livello di attenzione corrente.
  double attention;

  // ==========================================================
  // MEMORIA
  // ==========================================================

  /// Quanto questa memoria è consolidata.
  double strength;

  /// Importanza cognitiva.
  double importance;

  /// Affidabilità della conoscenza.
  double confidence;

  /// Capacità di modificarsi.
  double plasticity;

  /// Velocità naturale di decadimento.
  double decayRate;

  /// Peso emotivo.
  double emotionalWeight;

  // ==========================================================
  // STATISTICHE
  // ==========================================================

  int activationCount;

  int retrievalCount;

  int updateCount;

  // ==========================================================
  // TEMPO
  // ==========================================================

  final DateTime createdAt;

  DateTime? lastActivated;

  DateTime? lastRetrieved;

  DateTime? lastUpdated;

  // ==========================================================
  // FLAGS
  // ==========================================================

  /// Non decade mai automaticamente.
  bool isPermanent;

  /// Non può essere modificato automaticamente.
  bool isLocked;

  NeuronState({
    this.activation = 0.0,
    this.attention = 0.0,

    this.strength = 0.5,
    this.importance = 0.5,
    this.confidence = 0.5,
    this.plasticity = 1.0,
    this.decayRate = 0.001,
    this.emotionalWeight = 0.0,

    this.activationCount = 0,
    this.retrievalCount = 0,
    this.updateCount = 0,

    DateTime? createdAt,
    this.lastActivated,
    this.lastRetrieved,
    this.lastUpdated,

    this.isPermanent = false,
    this.isLocked = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      "activation": activation,
      "attention": attention,

      "strength": strength,
      "importance": importance,
      "confidence": confidence,
      "plasticity": plasticity,
      "decayRate": decayRate,
      "emotionalWeight": emotionalWeight,

      "activationCount": activationCount,
      "retrievalCount": retrievalCount,
      "updateCount": updateCount,

      "createdAt": createdAt.millisecondsSinceEpoch,
      "lastActivated": lastActivated?.millisecondsSinceEpoch,
      "lastRetrieved": lastRetrieved?.millisecondsSinceEpoch,
      "lastUpdated": lastUpdated?.millisecondsSinceEpoch,

      "isPermanent": isPermanent,
      "isLocked": isLocked,
    };
  }

  factory NeuronState.fromJson(
    Map<String, dynamic> json,
  ) {
    return NeuronState(
      activation: (json["activation"] ?? 0.0).toDouble(),
      attention: (json["attention"] ?? 0.0).toDouble(),

      strength: (json["strength"] ?? 0.5).toDouble(),
      importance: (json["importance"] ?? 0.5).toDouble(),
      confidence: (json["confidence"] ?? 0.5).toDouble(),
      plasticity: (json["plasticity"] ?? 1.0).toDouble(),
      decayRate: (json["decayRate"] ?? 0.001).toDouble(),
      emotionalWeight:
          (json["emotionalWeight"] ?? 0.0).toDouble(),

      activationCount: json["activationCount"] ?? 0,
      retrievalCount: json["retrievalCount"] ?? 0,
      updateCount: json["updateCount"] ?? 0,

      createdAt: DateTime.fromMillisecondsSinceEpoch(
        json["createdAt"] ??
            DateTime.now().millisecondsSinceEpoch,
      ),

      lastActivated: json["lastActivated"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json["lastActivated"],
            )
          : null,

      lastRetrieved: json["lastRetrieved"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json["lastRetrieved"],
            )
          : null,

      lastUpdated: json["lastUpdated"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json["lastUpdated"],
            )
          : null,

      isPermanent: json["isPermanent"] ?? false,
      isLocked: json["isLocked"] ?? false,
    );
  }
}