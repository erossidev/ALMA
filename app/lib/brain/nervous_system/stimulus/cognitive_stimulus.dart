class CognitiveStimulus {
  /// Testo originale ricevuto.
  final String rawInput;

  /// Momento in cui è arrivato lo stimolo.
  final DateTime timestamp;

  const CognitiveStimulus({
    required this.rawInput,
    required this.timestamp,
  });
}