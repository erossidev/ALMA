import '../neuron.dart';

class NeuronDynamics {
  const NeuronDynamics._();

  // ==========================================================
  // ATTIVAZIONE
  // ==========================================================

  static void activate(
    Neuron neuron, {
    double stimulus = 1.0,
  }) {
    final s = neuron.state;

    s.activation = _clamp(
      s.activation + stimulus,
    );

    s.attention = _clamp(
      s.attention + stimulus,
    );

    s.activationCount++;

    s.lastActivated = DateTime.now();
  }

  // ==========================================================
  // RECUPERO MEMORIA
  // ==========================================================

  static void retrieve(
    Neuron neuron,
  ) {
    final s = neuron.state;

    s.retrievalCount++;

    s.lastRetrieved = DateTime.now();

    reinforce(
      neuron,
      amount: 0.01,
    );
  }

  // ==========================================================
  // RAFFORZAMENTO
  // ==========================================================

  static void reinforce(
    Neuron neuron, {
    double amount = 0.02,
  }) {
    final s = neuron.state;

    s.strength = _clamp(
      s.strength + amount * s.plasticity,
    );

    s.importance = _clamp(
      s.importance + amount * 0.5,
    );
  }

  // ==========================================================
  // INDEBOLIMENTO
  // ==========================================================

  static void weaken(
    Neuron neuron, {
    double amount = 0.01,
  }) {
    final s = neuron.state;

    if (s.isPermanent) {
      return;
    }

    s.strength = _clamp(
      s.strength - amount,
    );

    s.importance = _clamp(
      s.importance - amount * 0.5,
    );
  }

  // ==========================================================
  // CONSOLIDAMENTO
  // ==========================================================

  static void consolidate(
    Neuron neuron, {
    double amount = 0.03,
  }) {
    final s = neuron.state;

    s.confidence = _clamp(
      s.confidence + amount,
    );

    s.strength = _clamp(
      s.strength + amount,
    );

    s.plasticity = _clamp(
      s.plasticity - amount * 0.2,
    );
  }

  // ==========================================================
  // DIMENTICANZA
  // ==========================================================

  static void decay(
    Neuron neuron,
  ) {
    final s = neuron.state;

    if (s.isPermanent) {
      return;
    }

    s.activation = _clamp(
      s.activation - s.decayRate,
    );

    s.attention = _clamp(
      s.attention - s.decayRate,
    );

    s.strength = _clamp(
      s.strength -
          s.decayRate * 0.1,
    );
  }

  // ==========================================================
  // MODIFICA
  // ==========================================================

  static void update(
    Neuron neuron,
  ) {
    final s = neuron.state;

    s.updateCount++;

    s.lastUpdated =
        DateTime.now();
  }

  // ==========================================================
  // RESET ATTIVAZIONE
  // ==========================================================

  static void resetActivation(
    Neuron neuron,
  ) {
    final s = neuron.state;

    s.activation = 0.0;

    s.attention = 0.0;
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