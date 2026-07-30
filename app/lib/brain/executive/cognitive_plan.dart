import 'cognitive_task.dart';

class CognitivePlan {
  final List<CognitiveTask> tasks;

  const CognitivePlan({
    required this.tasks,
  });

  bool get isEmpty => tasks.isEmpty;
}