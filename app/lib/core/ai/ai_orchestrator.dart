import 'ai_provider.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_resource_resolver.dart';
import 'ai_response.dart';

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

    // Carica il catalogo AI dal backend
    final resources =
        await registry.loadResources();

    // Ottiene tutte le risorse compatibili,
    // ordinate dalla migliore alla peggiore
    final candidates =
        resolver.resolveCandidates(
      request: request,
      resources: resources,
    );

    if (candidates.isEmpty) {
      throw Exception(
        "Nessuna risorsa AI disponibile.",
      );
    }

    Exception? lastError;

    // Prova una risorsa alla volta
    for (final AIResource resource in candidates) {

      final AIProvider provider =
          providerRegistry.getProvider(
        resource.providerId,
      );

      try {

        print(
          "🧠 Provo ${resource.displayName}"
          " (${resource.providerId})",
        );

        final response =
            await provider.sendMessage(
          request: request,
          resource: resource,
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