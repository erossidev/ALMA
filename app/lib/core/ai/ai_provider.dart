import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_response.dart';

abstract class AIProvider {
  Future<AIResponse> sendMessage({
    required AIRequest request,
    required AIResource resource,
  });
}