import '../ai_request.dart';
import '../ai_response.dart';

abstract class AIExecutionRecorder {
  const AIExecutionRecorder();

  Future<void> record({
    required AIRequest request,
    required AIResponse response,
  });
}