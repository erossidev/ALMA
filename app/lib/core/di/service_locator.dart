import '../ai/ai_provider_registry.dart';
import '../ai/backend_ai_registry.dart';
import '../ai/backend_ai_service.dart';

class ServiceLocator {
  ServiceLocator._();

  static final AIProviderRegistry aiProviderRegistry =
      AIProviderRegistry();

  static final BackendAIRegistry backendAIRegistry =
      BackendAIRegistry();

  static final BackendAIService backendAIService =
      BackendAIService(
        registry: backendAIRegistry,
      );
}