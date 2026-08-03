import '../ai_request.dart';
import '../ai_resource.dart';
import '../ai_response.dart';

class AIExecution {
  final String id;

  final DateTime timestamp;

  final AIRequest request;

  final AIResource resource;

  final AIResponse response;

  const AIExecution({
    required this.id,
    required this.timestamp,
    required this.request,
    required this.resource,
    required this.response,
  });

  factory AIExecution.now({
    required AIRequest request,
    required AIResource resource,
    required AIResponse response,
  }) {
    return AIExecution(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      request: request,
      resource: resource,
      response: response,
    );
  }
}