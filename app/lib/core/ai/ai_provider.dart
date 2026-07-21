import 'ai_response.dart';

abstract class AIProvider {
  Future<AIResponse> sendMessage(String message);
}