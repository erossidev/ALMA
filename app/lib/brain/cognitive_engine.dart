import '../core/ai/ai_manager.dart';
import '../core/ai/ai_response.dart';

import 'brain.dart';
import 'working_memory.dart';

import 'attention/attention_engine.dart';
import 'hippocampus/hippocampus.dart';

import 'memory/brain_memory_manager.dart';
import 'language/context_builder.dart';

import 'learning/learning_pipeline.dart';

import 'repositories/brain_repository.dart';

import 'retrieval/memory_retriever.dart';
import 'retrieval/memory_result.dart';

import 'knowledge/knowledge_pipeline.dart';

import 'protocol/brain_executor.dart';
import 'protocol/brain_result.dart';

import 'clarification/pending_clarification.dart';
import 'clarification/clarification_resolver.dart';

import '../core/dialogue/builders/ai_conversation_builder.dart';
import '../core/dialogue/models/conversation_model.dart';

class CognitiveEngine {
  final Brain brain;

  final WorkingMemory workingMemory;

  final AttentionEngine attentionEngine;

  final Hippocampus hippocampus;

  final AIManager aiManager;

  final BrainRepository repository;

  late final AIConversationBuilder _conversationBuilder =
    AIConversationBuilder(
      ai: aiManager,
    );


    ConversationModel _conversation =
        ConversationModel.empty;

  late final BrainMemoryManager _brainMemoryManager =
      BrainMemoryManager(
        brain: brain,
        repository: repository,
      );

  late final LearningPipeline _learningPipeline =
      LearningPipeline(
        aiManager: aiManager,
      );

  late final BrainExecutor _brainExecutor =
      BrainExecutor(
        brainMemoryManager: _brainMemoryManager,
      );

  late final KnowledgePipeline _knowledgePipeline =
      KnowledgePipeline(
        aiManager: aiManager,
        brainExecutor: _brainExecutor,
      );

  late final MemoryRetriever _memoryRetriever =
      MemoryRetriever(
        brain,
      );

  final ContextBuilder _contextBuilder =
      ContextBuilder();

      PendingClarification? _pendingClarification;

      final ClarificationResolver
          _clarificationResolver =
              const ClarificationResolver();

  CognitiveEngine({
    required this.brain,
    required this.workingMemory,
    required this.attentionEngine,
    required this.hippocampus,
    required this.aiManager,
    required this.repository,
  });

  // =====================================================
  // CICLO COGNITIVO
  // =====================================================

  Future<AIResponse> think(
    
    String message,
  ) async {

    _conversation =
        await _conversationBuilder.update(
      conversation: _conversation,
      message: message,
      );

      print("========== CONVERSATION ==========");
      print(_conversation.toJson());
      print("==================================");

  if (_pendingClarification != null) {

    final instruction =
        _clarificationResolver.resolve(
      conflict:
          _pendingClarification!.conflict,
      answer: message,
    );

    final result =
        await _brainExecutor.execute(
      instruction,
    );

    _pendingClarification = null;

    return AIResponse(
      reply: result.success
          ? "Perfetto, ho aggiornato la memoria."
          : "Va bene, mantengo l'informazione precedente.",
      provider: "ALMA Brain",
      model: "Clarification",
    );

}
  
    await perceive(
      message,
    );

    final brainResult =
        await remember(
      message,
    );

  if (brainResult.requiresClarification) {

      _pendingClarification =
          PendingClarification(
        conflict: brainResult.conflict!,
        question:
            brainResult.question ??
            "Puoi chiarire questa informazione?",
        createdAt: DateTime.now(),
      );

      return AIResponse(
        reply:
            brainResult.question ??
            "Puoi chiarire questa informazione?",
        provider: "ALMA Brain",
        model: "Clarification",
      );

    }


    final prompt =
        buildContext(
      message,
    );

    final response =
        await aiManager.generateResponse(
      prompt,
    );

    await learn(
      message,
      response,
    );

    return response;
  }

  // =====================================================
  // PERCEZIONE
  // =====================================================

  Future<void> perceive(
    String message,
  ) async {

    // Futuro:
    // - Intent Detection
    // - Emotion Detection
    // - Decision Layer

  }

  // =====================================================
  // MEMORIA
  // =====================================================

  Future<BrainResult> remember(
    String message,
  ) async {

    final decision =
        await _learningPipeline.process(
      message,
    );

    if (!decision.shouldLearn) {

      print(">>> Learning skipped");

      return BrainResult.ignored();

    }

    final result =
        await _knowledgePipeline.process(
      message,
    );

    print(brain);

    return result;
  }

  // =====================================================
  // COSTRUZIONE CONTESTO
  // =====================================================

  String buildContext(
    String message,
  ) {

    final MemoryResult memory =
        _memoryRetriever.retrieve(
      [
        "user",
      ],
    );

    final prompt =
        _contextBuilder.build(
      message,
      memory,
      _conversation,
    );

    print("");

    print("========== PROMPT ==========");
    print(prompt);
    print("============================");

    print("");

    return prompt;
  }

  // =====================================================
  // APPRENDIMENTO
  // =====================================================

  Future<void> learn(
    String message,
    AIResponse response,
  ) async {

    attentionEngine.update(
      workingMemory,
    );

    hippocampus.consolidate(
      workingMemory,
    );

  }

  // =====================================================
  // SONNO
  // =====================================================

  Future<void> sleep() async {

    hippocampus.consolidate(
      workingMemory,
    );

    brain.decayAll();

  }
}