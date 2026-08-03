import '../ai_response.dart';
import 'ai_provider_statistics.dart';

class AITelemetryService {
  final Map<String, AIProviderStatistics> _providers = {};

  void record(AIResponse response) {
    final provider = response.provider;

    final statistics = _providers.putIfAbsent(
      provider,
      () => AIProviderStatistics(
        providerId: provider,
      ),
    );

    statistics.add(
      prompt: response.usage.promptTokens,
      completion: response.usage.completionTokens,
      total: response.usage.totalTokens,
      responseTimeMs: response.usage.responseTimeMs,
    );
  }

  List<AIProviderStatistics> get providers =>
      _providers.values.toList();

  AIProviderStatistics? provider(
    String provider,
  ) {
    return _providers[provider];
  }

  void clear() {
    _providers.clear();
  }
}