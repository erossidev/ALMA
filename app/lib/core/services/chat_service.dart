import '../ai/ai_manager.dart';

class ChatService {
  final AIManager _aiManager = AIManager();

  Future<String> getResponse(String message) async {
    return await _aiManager.getResponse(message);
  }
}