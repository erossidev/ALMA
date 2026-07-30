import '../handlers/task_handler.dart';
import 'cognitive_plan.dart';
import 'execution_context.dart';
import 'task_type.dart';

class CognitiveExecutor {
  final Map<TaskType, TaskHandler> handlers;

  const CognitiveExecutor({
    required this.handlers,
  });

  Future<void> execute(
    CognitivePlan plan,
    ExecutionContext context,
  ) async {

    print("");
    print("===== EXECUTOR =====");

    print("Handlers registrati:");
    print(handlers.keys);

    for (final task in plan.tasks) {

      print("Task: ${task.type}");

      final handler =
          handlers[task.type];

          print("Handler trovato: ${handler != null}");

      if (handler == null) {
        continue;
      }

      final sw = Stopwatch()..start();

     await handler.execute(context);

      sw.stop();
      print(
        "⏱ ${task.type}: ${sw.elapsedMilliseconds} ms",
      );
    }
  }
}