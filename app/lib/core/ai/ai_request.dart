import 'ai_task.dart';

class AIRequest {
  final String prompt;

  /// Funzione cognitiva richiesta
  final AITask task;

  /// Capacità richieste al modello
  final List<String> requiredCapabilities;

  /// Resource scelta dal router
  final String? resourceId;

  /// Modello reale
  final String? model;

  final int? maxTokens;

  final double? temperature;

  final Duration? timeout;

  const AIRequest({
    required this.prompt,
    required this.task,
    required this.requiredCapabilities,
    this.resourceId,
    this.model,
    this.maxTokens,
    this.temperature,
    this.timeout,
  });

  AIRequest copyWith({
    String? resourceId,
    String? model,
  }) {
    return AIRequest(
      prompt: prompt,
      task: task,
      requiredCapabilities: requiredCapabilities,
      resourceId: resourceId ?? this.resourceId,
      model: model ?? this.model,
      maxTokens: maxTokens,
      temperature: temperature,
      timeout: timeout,
    );
  }
}