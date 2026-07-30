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

    print("");
    print("===== PLANNER =====");
    print("Intent: $intent");

    switch (intent) {

      case "greeting":

        print("Planner -> greeting");

        return const CognitivePlan(
          tasks: [
            CognitiveTask(type: TaskType.dialogue),
            CognitiveTask(type: TaskType.learning),
            CognitiveTask(type: TaskType.language),
            CognitiveTask(type: TaskType.memory),
          ],
        );

      case "question":

        print("Planner -> question");

        return const CognitivePlan(
          tasks: [
            CognitiveTask(type: TaskType.dialogue),
            CognitiveTask(type: TaskType.language),
            CognitiveTask(type: TaskType.memory),
          ],
        );

      case "conversation":

        print("Planner -> conversation");

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

        print("Planner -> default");

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