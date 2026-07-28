import 'ai_provider.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_resource_resolver.dart';
import 'ai_response.dart';
import '../cognition/profiler/cognitive_profiler.dart';

class AIOrchestrator {
  final AIRegistry registry;

  final AIResourceResolver resolver;

  final AIProviderRegistry providerRegistry;

  const AIOrchestrator({
    required this.registry,
    required this.resolver,
    required this.providerRegistry,
  });

  Future<AIResponse> execute(
    AIRequest request,
  ) async {

    // Carica il catalogo AI
    final resources =
        await registry.loadResources();

    // Ottiene i candidati ordinati
    final candidates =
        resolver.resolveCandidates(
      request: request,
      resources: resources,
    );

    // Doppia sicurezza
    final activeCandidates =
        candidates
            .where((e) => e.enabled)
            .toList();

    if (activeCandidates.isEmpty) {
      throw Exception(
        "Nessuna risorsa AI disponibile.",
      );
    }

    print("");
    print("===== MODEL SELECTION =====");

    for (final model in activeCandidates) {
      print(
        "${model.priority}. "
        "${model.displayName}"
        " (${model.providerId})",
      );
    }

    print("==========================");
    print("");

    Exception? lastError;

    for (final AIResource resource
        in activeCandidates) {

      final AIProvider provider =
          providerRegistry.getProvider(
        resource.providerId,
      );

      try {

        print(
          "🧠 Provo "
          "${resource.displayName}"
          " (${resource.providerId})",
        );

        final response =
            await provider.sendMessage(
          request: request,
          resource: resource,
        );

        print(
          "✅ ${resource.displayName}",
        );

        return response;

      } catch (e) {

        print(
          "❌ ${resource.displayName}: $e",
        );

        lastError = Exception(e);

      }

    }

    throw lastError ??
        Exception(
          "Nessun provider AI disponibile.",
        );
  }
}