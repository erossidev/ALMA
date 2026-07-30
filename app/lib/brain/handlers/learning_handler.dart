import '../learning/learning_pipeline.dart';
import '../executive/execution_context.dart';
import '../protocol/brain_result.dart';
import 'task_handler.dart';

class LearningHandler implements TaskHandler {

  final LearningPipeline learningPipeline;

  const LearningHandler({
    required this.learningPipeline,
  });

  @override
  Future<void> execute(
    ExecutionContext context,
  ) async {

    print(">>> LearningHandler EXECUTED");

    try {

      final decision =
          await learningPipeline.process(
        context.input,
      );

      context.shouldLearn =
          decision.shouldLearn;

      if (!decision.shouldLearn) {
        context.brainResult =
            BrainResult.ignored();
      }

    } catch (e, stackTrace) {

      print("");
      print("===== LEARNING ERROR =====");
      print(e);
      print(stackTrace);
      print("==========================");
      print("");

      // Se il sistema di apprendimento fallisce,
      // ALMA continua comunque la conversazione.

      context.shouldLearn = false;

      context.brainResult =
          BrainResult.ignored();

    }

  }
}