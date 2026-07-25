import '../../brain/cognitive_engine.dart';
import '../ai/ai_response.dart';
import '../alma/alma.dart';

class ChatService {
  final CognitiveEngine _cognitiveEngine =
      Alma.instance.cognitiveEngine;

  Future<AIResponse> sendMessage(
    String message,
  ) async {
    return await _cognitiveEngine.think(message);
  }
}