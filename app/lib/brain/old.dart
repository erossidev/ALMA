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

import '../core/cognition/profiler/cognitive_profiler.dart';

import '../core/cognition/cognitive_workspace.dart';

import 'nervous_system/nervous_system.dart';
import 'executive/executive_cortex.dart';
import 'executive/cognitive_executor.dart';
import 'executive/cognitive_planner.dart';
import 'nervous_system/perception/perception_engine.dart';
import 'executive/execution_context.dart';

import 'bootstrap/nervous_system_factory.dart';

class CognitiveEngine {
  final Brain brain;

  final CognitiveWorkspace workspace =
    CognitiveWorkspace();

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

    late final NervousSystem _nervousSystem =
      NervousSystemFactory.create(
        conversationBuilder: _conversationBuilder,
        learningPipeline: _learningPipeline,
        knowledgePipeline: _knowledgePipeline,
      );
      
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

    final profiler = CognitiveProfiler();
    profiler.start();

    profiler.begin("Dialogue");
    
    final thought = workspace.getOrCreateThought(
      conversation: _conversation,
      workingMemory: workingMemory,
    );

    final context = ExecutionContext(
      thought: thought,
      input: message,
      conversation: _conversation,
    );

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
    profiler.begin("Perception");

    await perceive(
      context,
    );

    _conversation = context.conversation;

    profiler.end("Perception");

    profiler.begin("Brain");

    final brainResult = context.brainResult;

      profiler.end("Brain");

      if (brainResult != null &&
          brainResult.requiresClarification) {

          _pendingClarification = PendingClarification(
            conflict: brainResult.conflict!,
            question: brainResult.question ??
                "Puoi chiarire questa informazione?",
            createdAt: DateTime.now(),
          );

          return AIResponse(
            reply: brainResult.question ??
                "Puoi chiarire questa informazione?",
            provider: "ALMA Brain",
            model: "Clarification",
          );
      }

    }

    profiler.begin("Context");

    final prompt =
        buildContext(
      message,
    );

    profiler.end("Context");

    profiler.begin("Chat");

    final response =
        await aiManager.generateResponse(
      prompt,
    );

    profiler.end("Chat");

    profiler.begin("Learn");

    await learn(
      message,
      response,
    );

    profiler.end("Learn");

    profiler.printReport();

    return response;
  }

  // =====================================================
  // PERCEZIONE
  // =====================================================

 Future<void> perceive(
  ExecutionContext context,
) async {

  await _nervousSystem.process(
    context,
  );

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

    final thought = workspace.activeThought!;

    final prompt =
        _contextBuilder.build(
      thought,
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