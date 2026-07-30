import '../../core/ai/ai_manager.dart';

import '../executive/execution_context.dart';
import '../language/context_builder.dart';
import '../retrieval/memory_retriever.dart';

import 'task_handler.dart';

class LanguageHandler implements TaskHandler {

  final MemoryRetriever memoryRetriever;

  final ContextBuilder contextBuilder;

  final AIManager aiManager;

  const LanguageHandler({
    required this.memoryRetriever,
    required this.contextBuilder,
    required this.aiManager,
  });

  @override
  Future<void> execute(
    ExecutionContext context,
  ) async {

    print(">>> LanguageHandler EXECUTED");

    final memory =
        memoryRetriever.retrieve(
      ["user"],
    );

    final prompt =
        contextBuilder.build(
      context.thought,
      context.input,
      memory,
    );

    print("");
    print("========== PROMPT ==========");
    print(prompt);
    print("============================");
    print("");

    final response =
        await aiManager.generateResponse(
      prompt,
    );
    
    context.response = response;
  }

}