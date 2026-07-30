import '../stimulus/cognitive_stimulus.dart';
import 'perception_result.dart';

class PerceptionEngine {
  const PerceptionEngine();

  PerceptionResult analyze(
    CognitiveStimulus stimulus,
  ) {
    final text = stimulus.rawInput.toLowerCase();

    if (text.startsWith("ciao")) {
      return PerceptionResult(
        stimulus: stimulus,
        intent: "greeting",
        confidence: 1.0,
      );
    }

    if (text.contains("mi chiamo")) {
      return PerceptionResult(
        stimulus: stimulus,
        intent: "new_person",
        confidence: 1.0,
      );
    }

    return PerceptionResult(
      stimulus: stimulus,
      intent: "conversation",
      confidence: 0.5,
    );
  }
}