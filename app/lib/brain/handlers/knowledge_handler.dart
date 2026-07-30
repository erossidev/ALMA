import '../executive/execution_context.dart';
import '../knowledge/knowledge_pipeline.dart';
import 'task_handler.dart';

class KnowledgeHandler implements TaskHandler {

  final KnowledgePipeline knowledgePipeline;

  const KnowledgeHandler({
    required this.knowledgePipeline,
  });

  @override
  Future<void> execute(
    ExecutionContext context,
  ) async {

    print(">>> KnowledgeHandler EXECUTED");

    if (!context.shouldLearn) {
      return;
    }

    context.brainResult =
        await knowledgePipeline.process(
      context.input,
    );
  }
}