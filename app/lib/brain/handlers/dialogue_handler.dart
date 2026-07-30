import '../../core/dialogue/builders/ai_conversation_builder.dart';

import '../executive/execution_context.dart';

import 'task_handler.dart';

import '../handlers/dialogue_handler.dart';

class DialogueHandler implements TaskHandler {
  final AIConversationBuilder builder;

  const DialogueHandler({
    required this.builder,
  });

  @override
  Future<void> execute(
    ExecutionContext context,
  ) async {

    print(">>> DialogueHandler EXECUTED");

    context.conversation =
        await builder.update(
      conversation: context.conversation,
      message: context.input,
    );

    context.thought.conversation =
        context.conversation;

  }
}