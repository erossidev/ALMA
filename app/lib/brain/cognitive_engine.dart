import '../core/ai/ai_manager.dart';
import '../core/ai/ai_response.dart';

import 'brain.dart';
import 'working_memory.dart';

import 'attention/attention_engine.dart';
import 'hippocampus/hippocampus.dart';

import 'language/brain_updater.dart';
import 'language/concept_extractor.dart';
import 'language/context_builder.dart';
import 'language/relation_extractor.dart';

import 'repositories/brain_repository.dart';

import 'retrieval/memory_retriever.dart';
import 'retrieval/memory_result.dart';

import 'semantics/semantic_pipeline.dart';

class CognitiveEngine {
  final Brain brain;
  final WorkingMemory workingMemory;
  final AttentionEngine attentionEngine;
  final Hippocampus hippocampus;
  final AIManager aiManager;
  final BrainRepository repository;

  late final BrainUpdater _brainUpdater =
      BrainUpdater(
        brain: brain,
        repository: repository,
      );

  late final SemanticPipeline _semanticPipeline =
    SemanticPipeline(
      aiManager: aiManager,
      brainUpdater: _brainUpdater,
    );

  final ConceptExtractor _conceptExtractor =
      ConceptExtractor();

  final RelationExtractor _relationExtractor =
      RelationExtractor();

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

  /// =====================================================
  /// CICLO COGNITIVO
  /// =====================================================

  Future<AIResponse> think(String message) async {
    await perceive(message);

    await remember(message);

    final prompt = buildContext(message);

    final response =
    await aiManager.generateResponse(prompt);

    await learn(message, response);

    return response;
  }

  /// =====================================================
  /// PERCEZIONE
  /// =====================================================

  Future<void> perceive(String message) async {
    // Versione 1
    // In futuro:
    // - Intent Detection
    // - Emotion Detection
    // - NLP avanzato
  }

  /// =====================================================
  /// MEMORIA
  /// =====================================================

  Future<void> remember(
  String message,
  ) async {

  // =====================================
  // NUOVA PIPELINE SEMANTICA
  // =====================================

  try {

    await _semanticPipeline.process(
      message,
    );

    return;

  } catch (e) {

    print(
      "Semantic pipeline failed: $e",
    );

  }

  // =====================================
  // FALLBACK (TEMPORANEO)
  // =====================================

  final concepts =
      _conceptExtractor.extract(
    message,
  );

  final relations =
      _relationExtractor.extract(
    message,
  );

  await _brainUpdater.update(
    concepts: concepts,
    relations: relations,
  );

  for (final concept in concepts) {
    brain.activateNeuron(
      concept.id,
    );
  }

  print(brain);
  }

  /// =====================================================
  /// COSTRUZIONE CONTESTO
  /// =====================================================

  String buildContext(String message) {
    final MemoryResult memory =
        _memoryRetriever.retrieve(message);

    final prompt = _contextBuilder.build(
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

  /// =====================================================
  /// APPRENDIMENTO
  /// =====================================================

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

  /// =====================================================
  /// SONNO
  /// =====================================================

  Future<void> sleep() async {
    hippocampus.consolidate(
      workingMemory,
    );

    brain.decayAll();
  }
}