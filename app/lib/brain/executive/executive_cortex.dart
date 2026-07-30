import '../nervous_system/perception/perception_engine.dart';
import '../nervous_system/stimulus/cognitive_stimulus.dart';
import 'cognitive_executor.dart';
import 'cognitive_planner.dart';
import 'execution_context.dart';


class ExecutiveCortex {
  final PerceptionEngine perceptionEngine;

  final CognitivePlanner planner;

  final CognitiveExecutor executor;

  ExecutiveCortex({
    required this.perceptionEngine,
    required this.planner,
    required this.executor,
  });

  Future<void> execute(
    ExecutionContext context,
  ) async {
    // ============================
    // STIMULUS
    // ============================

    final stimulus = CognitiveStimulus(
      rawInput: context.input,
      timestamp: DateTime.now(),
    );

    // ============================
    // PERCEPTION
    // ============================

    context.perception =
        perceptionEngine.analyze(
      stimulus,
    );

    // ============================
    // PLANNING
    // ============================

    context.plan =
        planner.createPlan(
      context,
    );

    // ============================
    // DEBUG
    // ============================

    print("");
    print("===== PERCEPTION =====");
    print(context.perception!.intent);
    print("======================");

    print("");
    print("===== PLAN =====");

    for (final task in context.plan!.tasks) {
      print(task.type);
    }

    print("================");

    // ============================
    // EXECUTION
    // ============================

    await executor.execute(
      context.plan!,
      context,
    );
  }
}