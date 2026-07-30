import '../stimulus/cognitive_stimulus.dart';

class PerceptionResult {
  /// Stimolo ricevuto.
  final CognitiveStimulus stimulus;

  /// Intento rilevato.
  final String intent;

  /// Livello di confidenza.
  final double confidence;

  const PerceptionResult({
    required this.stimulus,
    required this.intent,
    required this.confidence,
  });
}