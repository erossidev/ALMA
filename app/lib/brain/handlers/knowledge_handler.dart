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

    try {

      context.brainResult =
          await knowledgePipeline.process(
        context.input,
      );

    } catch (e, stackTrace) {

      print("");
      print("===== KNOWLEDGE ERROR =====");
      print(e);
      print(stackTrace);
      print("===========================");
      print("");

      // Non interrompere la pipeline.
      // Sarà il Brain Protocol a decidere se
      // ignorare, memorizzare o chiedere chiarimenti.

    }

  }

}