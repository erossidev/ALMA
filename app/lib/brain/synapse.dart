import 'neuron.dart';

enum RelationshipType {
  relatedTo,
  partOf,
  uses,
  createdBy,
  likes,
  knows,
  causedBy,
  belongsTo,
  similarTo,
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
}