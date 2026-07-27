import 'ai_provider.dart';
import 'ai_provider_registry.dart';
import 'ai_registry.dart';
import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_resource_resolver.dart';

class AIOrchestrator {
  final AIRegistry registry;

  final AIResourceResolver resolver;

  final AIProviderRegistry providerRegistry;

  const AIOrchestrator({
    required this.registry,
    required this.resolver,
    required this.providerRegistry,
  });

  Future<AIProvider> resolveProvider(
    AIRequest request,
  ) async {
    final resources =
        await registry.loadResources();

    final resource =
        resolver.resolve(
      request: request,
      resources: resources,
    );

    if (resource == null) {
      throw Exception(
        "Nessuna risorsa AI disponibile.",
      );
    }

    return providerRegistry.getProvider(
      resource.providerId,
    );
  }

  Future<AIResource> resolveResource(
    AIRequest request,
  ) async {
    final resources =
        await registry.loadResources();

    final resource =
        resolver.resolve(
      request: request,
      resources: resources,
    );

    if (resource == null) {
      throw Exception(
        "Nessuna risorsa AI disponibile.",
      );
    }

    return resource;
  }
}