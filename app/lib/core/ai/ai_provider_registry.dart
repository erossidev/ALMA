import 'ai_provider.dart';
import 'providers/openai_provider.dart';

class AIProviderRegistry {
  AIProviderRegistry();

  final Map<String, AIProvider> _providers = {
    "openrouter": OpenAIProvider(),
  };

  AIProvider getProvider(
    String providerId,
  ) {
    final provider = _providers[providerId];

    if (provider == null) {
      throw Exception(
        "Provider '$providerId' non registrato.",
      );
    }

    return provider;
  }
}