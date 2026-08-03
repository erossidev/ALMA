import 'ai_provider.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_resource_resolver.dart';
import 'ai_response.dart';
import 'ai_router.dart';
import 'ai_task.dart';

import 'configuration/ai_configuration.dart';
import 'backend_ai_service.dart';


class AIOrchestrator {
  final AIRegistry registry;

  final AIResourceResolver resolver;

  final AIProviderRegistry providerRegistry;

  final BackendAIService backendAIService;


  const AIOrchestrator({
    required this.registry,
    required this.resolver,
    required this.providerRegistry,
    required this.backendAIService,
  });



  Future<AIResponse> execute(
    AIRequest request,
  ) async {


    // Carica tutte le risorse AI disponibili
    final resources =
        await registry.loadResources();



    // Filtra le risorse compatibili con il task
    final candidates =
        resolver.resolveCandidates(
      request: request,
      resources: resources,
    );



    final activeCandidates =
        candidates
            .where(
              (e) => e.enabled,
            )
            .toList();



    if (activeCandidates.isEmpty) {
      throw Exception(
        "Nessuna risorsa AI disponibile.",
      );
    }



    // ==============================
    // ROUTING DAL BACKEND
    // ==============================

    final routingJson =
        await backendAIService.loadRouting();



    final routing =
        <AITask, String>{};



    routingJson.forEach(
      (key, value) {

        final task =
            AITask.values.firstWhere(
          (e) => e.name == key,
          orElse: () =>
              AITask.dialogue,
        );


        routing[task] =
            value.toString();

      },
    );



    final configuration =
        AIConfiguration(
          routing: routing,
        );



    // Router con configurazione backend
    final router =
        AIRouter(
          configuration: configuration,
        );



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