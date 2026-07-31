import 'ai_orchestrator.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_response.dart';
import 'ai_resource_resolver.dart';
import 'backend_ai_registry.dart';
import 'ai_task.dart';

class AIManager {
  final AIOrchestrator _orchestrator;

  AIManager()
      : _orchestrator = AIOrchestrator(
          registry: BackendAIRegistry(),
          resolver: const AIResourceResolver(),
          providerRegistry: AIProviderRegistry(),
        );

  // =====================================================
  // CHAT
  // =====================================================

  Future<AIResponse> generateResponse(
    String prompt,
  ) async {
    return await _orchestrator.execute(
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
  // ESTRAZIONE SEMANTICA
  // =====================================================

  Future<String> extractKnowledge(
    String prompt,
  ) async {
    final response =
        await _orchestrator.execute(
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
  // LEARNING CLASSIFICATION
  // =====================================================

  Future<String> classifyLearning(
    String prompt,
  ) async {
    final response =
        await _orchestrator.execute(
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
  final response =
      await _orchestrator.execute(
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