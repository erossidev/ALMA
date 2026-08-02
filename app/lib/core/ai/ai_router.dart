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
          (r) => r.providerId == "groq",
        );

      case AITask.knowledge:
        print("USO OPENROUTER");
        return _find(
          resources,
          (r) => r.providerId == "openrouter",
        );
        
        case AITask.ontologyNormalization:
          print("USO GROQ (ONTOLOGY NORMALIZATION)");
          return _find(
            resources,
            (r) => r.providerId == "groq",
          );

      case AITask.reasoning:
        return _find(
          resources,
          (r) => r.providerId == "groq",
        );

      case AITask.planning:
        return _find(
          resources,
          (r) => r.providerId == "groq",
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
          (r) => r.providerId == "openrouter",
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

    throw Exception(
      "Nessuna AI compatibile trovata.",
    );
  }
}