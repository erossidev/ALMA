import '../executive/cognitive_executor.dart';
import '../executive/cognitive_planner.dart';
import '../executive/executive_cortex.dart';
import '../executive/task_type.dart';
import '../handlers/task_handler.dart';
import '../nervous_system/nervous_system.dart';
import '../nervous_system/perception/perception_engine.dart';
import '../../core/dialogue/builders/ai_conversation_builder.dart';
import '../handlers/dialogue_handler.dart';
import '../learning/learning_pipeline.dart';
import '../knowledge/knowledge_pipeline.dart';
import '../handlers/learning_handler.dart';
import '../handlers/knowledge_handler.dart';
import '../handlers/language_handler.dart';
import '../retrieval/memory_retriever.dart';
import '../language/context_builder.dart';
import '../../core/ai/ai_manager.dart';
import '../handlers/memory_handler.dart';
import '../attention/attention_engine.dart';
import '../hippocampus/hippocampus.dart';
import '../working_memory.dart';
import '../brain.dart';
import '../retrieval/brain_retriever.dart';

class NervousSystemFactory {
  const NervousSystemFactory();

  static NervousSystem create({
  required AIConversationBuilder conversationBuilder,
  required LearningPipeline learningPipeline,
  required KnowledgePipeline knowledgePipeline,
  required Brain brain,
  required AIManager aiManager,
  required AttentionEngine attentionEngine,
  required Hippocampus hippocampus,
  required WorkingMemory workingMemory,
}) {

    final dialogueHandler = DialogueHandler(
      builder: conversationBuilder,
    );
  
    final learningHandler = LearningHandler(
    learningPipeline: learningPipeline,
    );


    final knowledgeHandler = KnowledgeHandler(
    knowledgePipeline: knowledgePipeline,
    );

    final memoryRetriever = MemoryRetriever(
    brain,
    );

final contextBuilder = ContextBuilder();

    final languageHandler = LanguageHandler(
      memoryRetriever: memoryRetriever,
      contextBuilder: contextBuilder,
      aiManager: aiManager,
    );

   final memoryHandler = MemoryHandler(
      attentionEngine: attentionEngine,
      hippocampus: hippocampus,
      workingMemory: workingMemory,
      brainRetriever: BrainRetriever(
        brain,
      ),
);

    final handlers = <TaskType, TaskHandler>{
      TaskType.dialogue: dialogueHandler,
      TaskType.learning: learningHandler,
      TaskType.knowledge: knowledgeHandler,
      TaskType.language: languageHandler,
      TaskType.memory: memoryHandler,
      
    };

    final executor = CognitiveExecutor(
      handlers: handlers,
    );

    final executive = ExecutiveCortex(
      perceptionEngine: const PerceptionEngine(),
      planner: const CognitivePlanner(),
      executor: executor,
    );

  

    return NervousSystem(
      executive: executive,
    );
  }
}