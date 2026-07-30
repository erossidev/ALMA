import 'cognitive_plan.dart';
import 'cognitive_task.dart';
import 'execution_context.dart';
import 'task_type.dart';

class CognitivePlanner {
  const CognitivePlanner();

  CognitivePlan createPlan(
    ExecutionContext context,
  ) {
    final intent =
        context.perception?.intent;

    switch (intent) {
      case "greeting":
        return const CognitivePlan(
        tasks: [
          CognitiveTask(type: TaskType.dialogue),
          CognitiveTask(type: TaskType.learning),
          CognitiveTask(type: TaskType.language),
          CognitiveTask(type: TaskType.memory),
        ],
      );

      case "new_person":
        return const CognitivePlan(
        tasks: [
          CognitiveTask(type: TaskType.dialogue),
          CognitiveTask(type: TaskType.learning),
          CognitiveTask(type: TaskType.knowledge),
          CognitiveTask(type: TaskType.language),
          CognitiveTask(type: TaskType.memory),
        ],
      );

      default:
        return const CognitivePlan(
          tasks: [
            
            CognitiveTask(type: TaskType.dialogue),
            CognitiveTask(type: TaskType.learning),
            CognitiveTask(type: TaskType.language),
            CognitiveTask(type: TaskType.memory),
            ],
        
        );
    }
  }
}