import 'ai_task.dart';

class AIRequest {
  final String prompt;

  /// Funzione cognitiva richiesta
  final AITask task;

  /// Capacità richieste al modello
  final List<String> requiredCapabilities;

  const AIRequest({
    required this.prompt,
    required this.task,
    required this.requiredCapabilities,
  });
}