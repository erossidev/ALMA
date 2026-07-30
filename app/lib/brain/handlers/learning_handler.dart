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
  }
}