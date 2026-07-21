import 'ai_provider.dart';
import 'ai_response.dart';
import 'providers/openai_provider.dart';

class AIManager {
  final AIProvider _provider;

  AIManager() : _provider = OpenAIProvider();

  Future<AIResponse> getResponse(String message) async {
    return await _provider.sendMessage(message);
  }
}