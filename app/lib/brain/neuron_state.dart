class NeuronState {
  /// Attivazione istantanea del neurone (0.0 - 1.0)
  double activation;

  /// Importanza a lungo termine del concetto (0.0 - 1.0)
  double importance;

  /// Quanto ALMA ritiene affidabile questa conoscenza (0.0 - 1.0)
  double confidence;

  /// Capacità del neurone di modificarsi (0.0 - 1.0)
  double plasticity;

  /// Peso emotivo associato al concetto (0.0 - 1.0)
  double emotionalWeight;

  /// Numero di attivazioni del neurone
  int activationCount;

  /// Ultima volta che il neurone è stato attivato
  DateTime? lastActivated;

  NeuronState({
    this.activation = 0.0,
    this.importance = 0.5,
    this.confidence = 0.5,
    this.plasticity = 1.0,
    this.emotionalWeight = 0.0,
    this.activationCount = 0,
    this.lastActivated,
  });

  /// Attiva il neurone
  void activate([double stimulus = 1.0]) {
    activation += stimulus;

    if (activation > 1.0) {
      activation = 1.0;
    }

    activationCount++;
    lastActivated = DateTime.now();
  }

  /// Il neurone perde gradualmente attivazione
  void decay([double amount = 0.05]) {
    activation -= amount;

    if (activation < 0.0) {
      activation = 0.0;
    }
  }

  /// Rafforza l'importanza del neurone.
  /// La plasticità determina quanto facilmente il neurone impara.
  void reinforce([double amount = 0.02]) {
    importance += amount * plasticity;

    if (importance > 1.0) {
      importance = 1.0;
    }
  }

  /// Riduce l'importanza del neurone.
  void weaken([double amount = 0.01]) {
    importance -= amount * plasticity;

    if (importance < 0.0) {
      importance = 0.0;
    }
  }

  /// Consolida una conoscenza.
  /// Aumenta la fiducia e riduce lentamente la plasticità.
  void consolidate([double amount = 0.05]) {
    confidence += amount;

    if (confidence > 1.0) {
      confidence = 1.0;
    }

    plasticity -= amount;

    if (plasticity < 0.1) {
      plasticity = 0.1;
    }
  }

  /// Dimenticanza graduale.
  void forget([double amount = 0.005]) {
    importance -= amount;

    if (importance < 0.0) {
      importance = 0.0;
    }
  }
}