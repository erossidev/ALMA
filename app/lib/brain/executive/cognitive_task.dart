import 'task_type.dart';

class CognitiveTask {
  final TaskType type;

  final int priority;

  final bool required;

  const CognitiveTask({
    required this.type,
    this.priority = 0,
    this.required = true,
  });
}