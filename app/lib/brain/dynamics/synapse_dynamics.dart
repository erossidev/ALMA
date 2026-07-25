import '../synapse.dart';

class SynapseDynamics {
  const SynapseDynamics._();

  // ==========================================================
  // ATTIVAZIONE
  // ==========================================================

  static void activate(
    Synapse synapse, {
    double stimulus = 1.0,
  }) {
    synapse.activation = _clamp(
      synapse.activation + stimulus,
    );

    synapse.activationCount++;

    synapse.lastActivated = DateTime.now();
  }

  // ==========================================================
  // UTILIZZO
  // ==========================================================

  static void retrieve(
    Synapse synapse,
  ) {
    synapse.usageCount++;

    synapse.lastUsed = DateTime.now();

    reinforce(
      synapse,
      amount: 0.01,
    );
  }

  // ==========================================================
  // RAFFORZAMENTO
  // ==========================================================

  static void reinforce(
    Synapse synapse, {
    double amount = 0.02,
  }) {
    synapse.weight = _clamp(
      synapse.weight +
          amount * synapse.plasticity,
    );

    synapse.confidence = _clamp(
      synapse.confidence +
          amount * 0.5,
    );

    synapse.lastUpdated =
        DateTime.now();
  }

  // ==========================================================
  // INDEBOLIMENTO
  // ==========================================================

  static void weaken(
    Synapse synapse, {
    double amount = 0.01,
  }) {
    if (synapse.isPermanent) {
      return;
    }

    synapse.weight = _clamp(
      synapse.weight - amount,
    );

    synapse.lastUpdated =
        DateTime.now();
  }

  // ==========================================================
  // CONSOLIDAMENTO
  // ==========================================================

  static void consolidate(
    Synapse synapse, {
    double amount = 0.03,
  }) {
    synapse.confidence = _clamp(
      synapse.confidence + amount,
    );

    synapse.weight = _clamp(
      synapse.weight + amount,
    );

    synapse.plasticity = _clamp(
      synapse.plasticity -
          amount * 0.2,
    );

    synapse.lastUpdated =
        DateTime.now();
  }

  // ==========================================================
  // DECADIMENTO
  // ==========================================================

  static void decay(
    Synapse synapse,
  ) {
    if (synapse.isPermanent) {
      return;
    }

    synapse.activation = _clamp(
      synapse.activation -
          synapse.decayRate,
    );

    synapse.weight = _clamp(
      synapse.weight -
          synapse.decayRate * 0.1,
    );
  }

  // ==========================================================
  // RESET ATTIVAZIONE
  // ==========================================================

  static void resetActivation(
    Synapse synapse,
  ) {
    synapse.activation = 0.0;
  }

  // ==========================================================
  // CLAMP
  // ==========================================================

  static double _clamp(
    double value,
  ) {
    if (value < 0.0) return 0.0;
    if (value > 1.0) return 1.0;

    return value;
  }
}