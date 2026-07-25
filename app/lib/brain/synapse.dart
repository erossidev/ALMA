import 'brain.dart';
import 'neuron.dart';

enum RelationshipType {
  // ==========================
  // GENERICHE
  // ==========================

  relatedTo,
  similarTo,
  partOf,
  causedBy,

  // ==========================
  // IDENTITÀ
  // ==========================

  hasName,
  alias,

  // ==========================
  // FAMIGLIA
  // ==========================

  hasFather,
  hasMother,
  hasSon,
  hasDaughter,
  hasBrother,
  hasSister,
  marriedTo,

  // ==========================
  // PERSONA
  // ==========================

  bornIn,
  livesIn,
  worksAt,
  studiedAt,

  // ==========================
  // POSSESSO
  // ==========================

  owns,
  hasPet,

  // ==========================
  // PREFERENZE
  // ==========================

  likes,
  dislikes,
  loves,
  hates,

  // ==========================
  // CONOSCENZA
  // ==========================

  knows,

  // ==========================
  // UTILIZZO
  // ==========================

  uses,
  createdBy,
  }

class Synapse {
  /// Identificatore univoco
  final String id;

  /// Neurone di origine
  final Neuron from;

  /// Neurone di destinazione
  final Neuron to;

  /// Tipo di relazione
  final RelationshipType relationship;

  /// Forza della connessione (0.0 - 1.0)
  double strength;

  /// Capacità della sinapsi di modificarsi (0.0 - 1.0)
  double plasticity;

  /// Numero di volte che è stata utilizzata
  int activationCount;

  /// Ultima attivazione
  DateTime? lastActivated;

  Synapse({
    required this.id,
    required this.from,
    required this.to,
    required this.relationship,
    this.strength = 0.2,
    this.plasticity = 1.0,
    this.activationCount = 0,
    this.lastActivated,
  });

  /// Attiva la sinapsi
  void activate() {
    activationCount++;
    lastActivated = DateTime.now();
  }

  /// Rafforza la connessione
  void strengthen([double amount = 0.02]) {
    strength += amount * plasticity;

    if (strength > 1.0) {
      strength = 1.0;
    }
  }

  /// Indebolisce la connessione
  void weaken([double amount = 0.01]) {
    strength -= amount * plasticity;

    if (strength < 0.0) {
      strength = 0.0;
    }
  }

  /// Consolidamento della connessione
  void consolidate([double amount = 0.05]) {
    plasticity -= amount;

    if (plasticity < 0.1) {
      plasticity = 0.1;
    }
  }

  /// Dimenticanza naturale
  void decay([double amount = 0.002]) {
    strength -= amount;

    if (strength < 0.0) {
      strength = 0.0;
    }
  }

  /// ==========================
  /// SERIALIZZAZIONE
  /// ==========================

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from': from.id,
      'to': to.id,
      'relationship': relationship.name,
      'strength': strength,
      'plasticity': plasticity,
      'activationCount': activationCount,
      'lastActivated':
          lastActivated?.millisecondsSinceEpoch,
    };
  }

  /// ==========================
  /// DESERIALIZZAZIONE
  /// ==========================

  factory Synapse.fromJson({
    required Map<String, dynamic> json,
    required Brain brain,
  }) {
    final from = brain.getNeuron(json['from']);
    final to = brain.getNeuron(json['to']);

    if (from == null || to == null) {
      throw Exception(
        'Impossibile ricostruire la sinapsi: neuroni mancanti.',
      );
    }

    return Synapse(
      id: json['id'],
      from: from,
      to: to,
      relationship: RelationshipType.values.firstWhere(
        (e) => e.name == json['relationship'],
      ),
      strength: (json['strength'] ?? 0.2).toDouble(),
      plasticity: (json['plasticity'] ?? 1.0).toDouble(),
      activationCount: json['activationCount'] ?? 0,
      lastActivated: json['lastActivated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              json['lastActivated'],
            )
          : null,
    );
  }
}