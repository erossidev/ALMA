import 'ai_resource.dart';
import 'ai_task.dart';

class AIRouter {
  const AIRouter();

  AIResource route(
    AITask task,
    List<AIResource> resources,
  ) {
    switch (task) {
      case AITask.dialogue:
        return _find(
          resources,
          (r) => r.providerId == "groq",
        );

      case AITask.language:
        return _find(
          resources,
          (r) => r.providerId == "groq",
        );

      case AITask.learning:
        return _find(
          resources,
          (r) => r.modelId == "openrouter/auto",
        );

      case AITask.knowledge:
        return _find(
          resources,
          (r) => r.modelId == "openrouter/auto",
        );

      case AITask.reasoning:
        return _find(
          resources,
          (r) => r.modelId == "openrouter/auto",
        );

      case AITask.planning:
        return _find(
          resources,
          (r) => r.modelId == "openrouter/auto",
        );

      case AITask.coding:
        return _find(
          resources,
          (r) => r.modelId.contains("gpt"),
        );

      case AITask.vision:
        return _find(
          resources,
          (r) => r.providerId == "gemini",
        );

      case AITask.emotion:
        return _find(
          resources,
          (r) => r.providerId == "groq",
        );

      case AITask.tool:
        return _find(
          resources,
          (r) => r.modelId == "openrouter/auto",
        );
    }
  }

  AIResource _find(
    List<AIResource> resources,
    bool Function(AIResource) test,
  ) {
    for (final resource in resources) {
      if (test(resource)) {
        return resource;
      }
    }

    // Fallback: restituisce la prima risorsa disponibile
    return resources.first;
  }
}