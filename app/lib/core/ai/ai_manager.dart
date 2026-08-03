import 'ai_orchestrator.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_response.dart';
import 'ai_resource_resolver.dart';
import 'backend_ai_registry.dart';
import 'ai_task.dart';

import 'services/ai_execution_recorder.dart';
import 'services/console_execution_recorder.dart';
import 'configuration/memory_ai_configuration_repository.dart';

class AIManager {
  final AIOrchestrator _orchestrator;

  final AIExecutionRecorder _recorder =
      const ConsoleExecutionRecorder();

  AIManager()
    : _orchestrator = AIOrchestrator(
        registry: BackendAIRegistry(),
        resolver: const AIResourceResolver(),
        providerRegistry: AIProviderRegistry(),
        configurationRepository:
            MemoryAIConfigurationRepository(),
      );

  // =====================================================
  // ESECUZIONE GENERICA
  // =====================================================

  Future<AIResponse> _execute(
    AIRequest request,
  ) async {
    final response =
        await _orchestrator.execute(request);

    await _recorder.record(
      request: request,
      response: response,
    );

    return response;
  }

  // =====================================================
  // CHAT
  // =====================================================

  Future<AIResponse> generateResponse(
    String prompt,
  ) async {
    return await _execute(
      AIRequest(
        prompt: prompt,
        task: AITask.language,
        requiredCapabilities: const [
          "conversation",
        ],
      ),
    );
  }

  // =====================================================
  // KNOWLEDGE
  // =====================================================

  Future<String> extractKnowledge(
    String prompt,
  ) async {
    final response = await _execute(
      AIRequest(
        prompt: prompt,
        task: AITask.knowledge,
        requiredCapabilities: const [
          "reasoning",
          "json",
        ],
      ),
    );

    return response.reply;
  }

  // =====================================================
  // LEARNING
  // =====================================================

  Future<String> classifyLearning(
    String prompt,
  ) async {
    final response = await _execute(
      AIRequest(
        prompt: prompt,
        task: AITask.learning,
        requiredCapabilities: const [
          "reasoning",
        ],
      ),
    );

    return response.reply;
  }

  // =====================================================
  // ONTOLOGY NORMALIZATION
  // =====================================================

  Future<String> normalizeOntology(
    String prompt,
  ) async {
    final response = await _execute(
      AIRequest(
        prompt: prompt,
        task: AITask.ontologyNormalization,
        requiredCapabilities: const [
          "reasoning",
          "json",
        ],
      ),
    );

    return response.reply;
  }
}