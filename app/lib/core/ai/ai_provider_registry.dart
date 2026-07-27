import 'ai_provider.dart';
import 'providers/backend_ai_provider.dart';

class AIProviderRegistry {
  AIProviderRegistry();

  final AIProvider _provider = BackendAIProvider();

  AIProvider getProvider(String providerId) {
    return _provider;
  }
}