import '../ai/ai_manager.dart';
import '../ai/ai_response.dart';

class ChatService {
  final AIManager _aiManager = AIManager();

  Future<AIResponse> getResponse(String message) async {
    return await _aiManager.getResponse(message);
  }
}