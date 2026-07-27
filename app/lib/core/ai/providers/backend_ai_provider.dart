import 'dart:convert';

import 'package:http/http.dart' as http;

import '../ai_provider.dart';
import '../ai_request.dart';
import '../ai_resource.dart';
import '../ai_response.dart';

class BackendAIProvider implements AIProvider {
  @override
  Future<AIResponse> sendMessage({
    required AIRequest request,
    required AIResource resource,
  }) async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/chat"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "message": request.prompt,
        "provider": resource.providerId,
        "model": resource.modelId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Errore AI");
    }

    final json = jsonDecode(response.body);

    return AIResponse(
      reply: json["reply"],
      provider: json["provider"],
      model: json["model"],
    );
  }
}