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

  final ConceptExtractor _conceptExtractor =
      ConceptExtractor();

  final RelationExtractor _relationExtractor =
      RelationExtractor();

  late final ContextBuilder _contextBuilder =
      ContextBuilder(brain);

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
        await aiManager.getResponse(prompt);

    await learn(message, response);

    return response;
  }

  /// =====================================================
  /// PERCEZIONE
  /// =====================================================

  Future<void> perceive(String message) async {
    // Versione 1
    // In futuro:
    // - NLP
    // - Intent Detection
    // - Emotion Detection
  }

  /// =====================================================
  /// MEMORIA
  /// =====================================================

  Future<void> remember(String message) async {
    final concepts =
        _conceptExtractor.extract(message);

    final relations =
        _relationExtractor.extract(message);

    await _brainUpdater.update(
      concepts: concepts,
      relations: relations,
    );

    for (final concept in concepts) {
      brain.activateNeuron(concept.id);
    }

    print(brain);
  }

  /// =====================================================
  /// CONTESTO
  /// =====================================================

  String buildContext(String message) {
    return _contextBuilder.build(message);
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