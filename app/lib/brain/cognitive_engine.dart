import '../core/ai/ai_manager.dart';
import '../core/ai/ai_response.dart';
import 'brain.dart';
import 'working_memory.dart';
import 'attention/attention_engine.dart';
import 'hippocampus/hippocampus.dart';
import 'memory/brain_memory_manager.dart';
import 'learning/learning_pipeline.dart';
import 'repositories/brain_repository.dart';
import 'knowledge/knowledge_pipeline.dart';
import 'protocol/brain_executor.dart';
import 'protocol/brain_result.dart';
import 'clarification/pending_clarification.dart';
import 'clarification/clarification_resolver.dart';
import '../core/cognition/cognitive_workspace.dart';
import '../core/dialogue/models/conversation_model.dart';
import '../brain/bootstrap/nervous_system_factory.dart';
import '../brain/nervous_system/nervous_system.dart';
import '../core/dialogue/builders/ai_conversation_builder.dart';
import 'executive/execution_context.dart';
import 'knowledge/knowledge_json_mapper.dart';
import 'knowledge/knowledge_parser.dart';
import '../core/ai/services/ai_ontology_normalizer.dart';
import 'semantic/semantic_cortex.dart';
import 'semantic/similarity/similarity_engine.dart';
import 'semantic/learning/ai_semantic_advisor.dart';
import 'semantic/learning/semantic_learning_engine.dart';

class CognitiveEngine {

  final AIManager aiManager;

  final CognitiveWorkspace workspace =
    CognitiveWorkspace();

  final Brain brain;

  final WorkingMemory workingMemory;

  final AttentionEngine attentionEngine;

  final Hippocampus hippocampus;

  
  final BrainRepository repository;
  ConversationModel _conversation =
    ConversationModel.empty;

    late final AIConversationBuilder _conversationBuilder =
    AIConversationBuilder(
      ai: aiManager,
    );

    late final NervousSystem _nervousSystem =
        NervousSystemFactory.create(
        conversationBuilder: _conversationBuilder,
        learningPipeline: _learningPipeline,
        knowledgePipeline: _knowledgePipeline,
        brain: brain,
        aiManager: aiManager,
        attentionEngine: attentionEngine,
        hippocampus: hippocampus,
        workingMemory: workingMemory,
    );
 
  late final BrainMemoryManager _brainMemoryManager =
      BrainMemoryManager(
        brain: brain,
        repository: repository,
      );

  late final SimilarityEngine _similarityEngine =
    SimilarityEngine(
      cortex: brain.semantic,
    );

  late final AISemanticAdvisor _semanticAdvisor =
      AISemanticAdvisor(
        aiManager: aiManager,
      );

  late final SemanticLearningEngine _semanticLearningEngine =
      SemanticLearningEngine(
        advisor: _semanticAdvisor,
        similarityEngine: _similarityEngine,
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
      ontologyNormalizer: OntologyNormalizerService(
        aiManager: aiManager,
        parser: const KnowledgeParser(),
        codec: const KnowledgeJsonMapper(),
      ),
      semanticLearningEngine: _semanticLearningEngine,
    );
    
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

    final total = Stopwatch()..start();

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

    total.stop();

print("");
print("============= PERFORMANCE =============");
print("Tempo totale: ${total.elapsedMilliseconds} ms");
print("=======================================");
print("");

    return AIResponse(
      reply: result.success
          ? "Perfetto, ho aggiornato la memoria."
          : "Va bene, mantengo l'informazione precedente.",
      provider: "ALMA Brain",
      model: "Clarification",
      
    );

    }

    final thought = workspace.getOrCreateThought(
      conversation: _conversation,
      workingMemory: workingMemory,
    );

    final context = ExecutionContext(
      thought: thought,
      input: message,
      conversation: _conversation,
    );

    await _nervousSystem.process(context);

    _conversation = context.conversation;
  

  
    final brainResult =
    context.brainResult;

    if (brainResult == null) {
      return context.response!;
    }

  if (brainResult.requiresClarification) {

     _pendingClarification = PendingClarification(
        conflict: brainResult.conflict,
        question: brainResult.question ??
            "Puoi chiarire questa informazione?",
        createdAt: DateTime.now(),
      );

    total.stop();

print("");
print("============= PERFORMANCE =============");
print("Tempo totale: ${total.elapsedMilliseconds} ms");
print("=======================================");
print("");

      return AIResponse(
        reply: brainResult.question ??
            "Puoi chiarire questa informazione?",
        provider: "ALMA Brain",
        model: "Clarification",
      );
    }



    return context.response!;
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