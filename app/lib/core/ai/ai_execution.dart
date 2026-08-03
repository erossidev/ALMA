import 'ai_request.dart';
import 'ai_resource.dart';
import 'ai_response.dart';

class AIExecution {
  final AIRequest request;

  final AIResource resource;

  final AIResponse response;

  final DateTime timestamp;

  const AIExecution({
    required this.request,
    required this.resource,
    required this.response,
    required this.timestamp,
  });

  factory AIExecution.now({
    required AIRequest request,
    required AIResource resource,
    required AIResponse response,
  }) {
    return AIExecution(
      request: request,
      resource: resource,
      response: response,
      timestamp: DateTime.now(),
    );
  }
}