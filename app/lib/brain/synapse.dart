import 'brain.dart';
import 'neuron.dart';

enum RelationshipType {
  // ==========================================================
  // GENERICHE
  // ==========================================================

  relatedTo,
  similarTo,
  partOf,
  causedBy,

  // ==========================================================
  // IDENTITÀ
  // ==========================================================

  hasName,
  alias,

  // ==========================================================
  // FAMIGLIA
  // ==========================================================

  hasFather,
  hasMother,
  hasSon,
  hasDaughter,
  hasBrother,
  hasSister,
  marriedTo,

  // ==========================================================
  // PERSONA
  // ==========================================================

  bornIn,
  livesIn,
  worksAt,
  studiedAt,

  // ==========================================================
  // POSSESSO
  // ==========================================================

  owns,
  hasPet,

  // ==========================================================
  // PREFERENZE
  // ==========================================================

  likes,
  dislikes,
  loves,
  hates,

  // ==========================================================
  // CONOSCENZA
  // ==========================================================

  knows,

  // ==========================================================
  // UTILIZZO
  // ==========================================================

  uses,
  createdBy,
}

class Synapse {
  // ==========================================================
  // IDENTITÀ
  // ==========================================================

  final String id;

  final Neuron from;

  final Neuron to;

  final RelationshipType relationship;

  // ==========================================================
  // STATO
  // ==========================================================

  /// Peso della connessione
  double weight;

  /// Affidabilità della connessione
  double confidence;

  /// Capacità di modificarsi
  double plasticity;

  /// Velocità di decadimento
  double decayRate;

  /// Attivazione corrente
  double activation;

  /// Peso emotivo
  double emotionalWeight;

  // ==========================================================
  // STATISTICHE
  // ==========================================================

  int activationCount;

  int usageCount;

  // ==========================================================
  // TEMPO
  // ==========================================================

  final DateTime createdAt;

  DateTime? lastActivated;

  DateTime? lastUsed;

  DateTime? lastUpdated;

  // ==========================================================
  // FLAGS
  // ==========================================================

  bool isPermanent;

  bool isLocked;

  Synapse({
    required this.id,
    required this.from,
    required this.to,
    required this.relationship,

    this.weight = 0.2,
    this.confidence = 0.5,
    this.plasticity = 1.0,
    this.decayRate = 0.001,
    this.activation = 0.0,
    this.emotionalWeight = 0.0,

    this.activationCount = 0,
    this.usageCount = 0,

    DateTime? createdAt,
    this.lastActivated,
    this.lastUsed,
    this.lastUpdated,

    this.isPermanent = false,
    this.isLocked = false,
  }) : createdAt = createdAt ?? DateTime.now();

  // ==========================================================
  // SERIALIZZAZIONE
  // ==========================================================

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "from": from.id,
      "to": to.id,
      "relationship": relationship.name,

      "weight": weight,
      "confidence": confidence,
      "plasticity": plasticity,
      "decayRate": decayRate,
      "activation": activation,
      "emotionalWeight": emotionalWeight,

      "activationCount": activationCount,
      "usageCount": usageCount,

      "createdAt": createdAt.millisecondsSinceEpoch,
      "lastActivated": lastActivated?.millisecondsSinceEpoch,
      "lastUsed": lastUsed?.millisecondsSinceEpoch,
      "lastUpdated": lastUpdated?.millisecondsSinceEpoch,

      "isPermanent": isPermanent,
      "isLocked": isLocked,
    };
  }

  // ==========================================================
  // DESERIALIZZAZIONE
  // ==========================================================

  factory Synapse.fromJson({
    required Map<String, dynamic> json,
    required Brain brain,
  }) {
    final from = brain.getNeuron(json["from"]);
    final to = brain.getNeuron(json["to"]);

    if (from == null || to == null) {
      throw Exception(
        "Impossibile ricostruire la sinapsi: neuroni mancanti.",
      );
    }

    return Synapse(
      id: json["id"],
      from: from,
      to: to,
      relationship: RelationshipType.values.firstWhere(
        (e) => e.name == json["relationship"],
      ),

      weight: (json["weight"] ?? 0.2).toDouble(),
      confidence: (json["confidence"] ?? 0.5).toDouble(),
      plasticity: (json["plasticity"] ?? 1.0).toDouble(),
      decayRate: (json["decayRate"] ?? 0.001).toDouble(),
      activation: (json["activation"] ?? 0.0).toDouble(),
      emotionalWeight:
          (json["emotionalWeight"] ?? 0.0).toDouble(),

      activationCount: json["activationCount"] ?? 0,
      usageCount: json["usageCount"] ?? 0,

      createdAt: json["createdAt"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json["createdAt"],
            )
          : DateTime.now(),

      lastActivated: json["lastActivated"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json["lastActivated"],
            )
          : null,

      lastUsed: json["lastUsed"] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json["lastUsed"],
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