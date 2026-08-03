import 'ai_provider.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_resource_resolver.dart';
import 'ai_response.dart';
import 'ai_router.dart';

import 'configuration/ai_configuration_repository.dart';

class AIOrchestrator {
  final AIRegistry registry;

  final AIResourceResolver resolver;

  final AIProviderRegistry providerRegistry;

  final AIConfigurationRepository configurationRepository;

  const AIOrchestrator({
    required this.registry,
    required this.resolver,
    required this.providerRegistry,
    required this.configurationRepository,
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

    // Carica la configurazione AI
    final configuration =
        await configurationRepository.load();

    // Crea il router con la configurazione corrente
    final router = AIRouter(
      configuration: configuration,
    );

    // Seleziona la risorsa
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