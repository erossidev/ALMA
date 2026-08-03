import '../ai_task.dart';

class AIConfiguration {
  final Map<AITask, String> routing;

  const AIConfiguration({
    required this.routing,
  });

  String resourceFor(AITask task) {
    final resourceId = routing[task];

    if (resourceId == null) {
      throw Exception(
        "Nessuna AI configurata per il task $task",
      );
    }

    return resourceId;
  }

  AIConfiguration copyWith({
    Map<AITask, String>? routing,
  }) {
    return AIConfiguration(
      routing: routing ?? this.routing,
    );
  }
}