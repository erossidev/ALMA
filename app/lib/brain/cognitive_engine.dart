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

import 'semantics/semantic_pipeline.dart';

import 'protocol/brain_executor.dart';

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

  late final SemanticPipeline _semanticPipeline =
    SemanticPipeline(
      aiManager: aiManager,
      brainExecutor: _brainExecutor,
    );

  late final MemoryRetriever _memoryRetriever =
      MemoryRetriever(brain);

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
    await perceive(message);

    await remember(message);

    final prompt = buildContext(message);

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
    // Versione 1
    // In futuro:
    // - Intent Detection
    // - Emotion Detection
    // - NLP avanzato
  }

  // =====================================================
  // MEMORIA
  // =====================================================

  Future<void> remember(
    String message,
  ) async {

    final decision =
        await _learningPipeline.process(
      message,
    );

    if (!decision.shouldLearn) {
      print(">>> Learning skipped");
      return;
    }

    await _semanticPipeline.process(
      message,
    );

    print(brain);
  }

  // =====================================================
  // COSTRUZIONE CONTESTO
  // =====================================================

  String buildContext(
    String message,
  ) {
    final MemoryResult memory =
        _memoryRetriever.retrieve(
      message,
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