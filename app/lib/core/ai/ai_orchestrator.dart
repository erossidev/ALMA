import 'ai_provider.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_resource_resolver.dart';
import 'ai_response.dart';
import 'ai_router.dart';

class AIOrchestrator {
  final AIRegistry registry;

  final AIResourceResolver resolver;

  final AIProviderRegistry providerRegistry;

  final AIRouter router = const AIRouter();

  const AIOrchestrator({
    required this.registry,
    required this.resolver,
    required this.providerRegistry,
  });

  Future<AIResponse> execute(
    AIRequest request,
  ) async {

    // Carica tutte le AI disponibili
    final resources =
        await registry.loadResources();

    // Filtra quelle compatibili con il task
    final candidates =
        resolver.resolveCandidates(
      request: request,
      resources: resources,
    );

    // Tiene solo quelle abilitate
    final activeCandidates =
        candidates
            .where((e) => e.enabled)
            .toList();

    if (activeCandidates.isEmpty) {
      throw Exception(
        "Nessuna risorsa AI disponibile.",
      );
    }

    // Il Router sceglie direttamente la migliore
    final AIResource resource =
        router.route(
      request.task,
      activeCandidates,
    );

    print("");
    print("===== MODEL SELECTION =====");
    print(resource.displayName);
    print("==========================");
    print("");

    final AIProvider provider =
        providerRegistry.getProvider(
      resource.providerId,
    );

    print(
      "🧠 ${resource.displayName}",
    );

    final AIResponse response =
        await provider.sendMessage(
      request: request,
      resource: resource,
    );

    print(
      "✅ ${resource.displayName}",
    );

    return response;
  }
}