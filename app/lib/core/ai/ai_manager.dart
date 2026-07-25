import 'ai_provider.dart';
import 'ai_response.dart';
import 'providers/openai_provider.dart';

class AIManager {
  final AIProvider _provider;

  AIManager() : _provider = OpenAIProvider();

  // =====================================================
  // CHAT
  // =====================================================

  Future<AIResponse> generateResponse(
    String prompt,
  ) async {
    return await _provider.sendMessage(prompt);
  }

  // =====================================================
  // ESTRAZIONE SEMANTICA
  // =====================================================

  Future<String> extractKnowledge(
    String prompt,
  ) async {
    final response =
        await _provider.sendMessage(prompt);

    return response.reply;
  }
}