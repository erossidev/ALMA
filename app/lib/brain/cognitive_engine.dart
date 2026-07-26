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

class CognitiveEngine {
  final Brain brain;

  final WorkingMemory workingMemory;

  final AttentionEngine attentionEngine;

  final Hippocampus hippocampus;

  final AIManager aiManager;

  final BrainRepository repository;

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

    await perceive(
      message,
    );

    try {

      final brainResult =
          await remember(
        message,
      );

      // ==========================================
      // IL BRAIN RICHIEDE UN CHIARIMENTO
      // ==========================================

      if (brainResult.requiresClarification) {

        return AIResponse(
          reply:
              brainResult.question ??
              "Puoi chiarire questa informazione?",
          provider: "ALMA Brain",
          model: "Clarification",
        );

      }

    } catch (e, stackTrace) {

      print("");
      print("===== MEMORY ERROR =====");
      print(e);
      print(stackTrace);
      print("========================");
      print("");

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