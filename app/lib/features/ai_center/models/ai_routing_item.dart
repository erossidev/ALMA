import '../../../core/ai/ai_task.dart';

class AIRoutingItem {
  final AITask task;

  /// ID della AI Resource (es. groq_llama70b)
  final String resourceId;

  const AIRoutingItem({
    required this.task,
    required this.resourceId,
  });

  AIRoutingItem copyWith({
    String? resourceId,
  }) {
    return AIRoutingItem(
      task: task,
      resourceId: resourceId ?? this.resourceId,
    );
  }
}