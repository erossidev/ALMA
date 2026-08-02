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
        "maxTokens": request.maxTokens,
          "temperature": request.temperature,
          "timeout": request.timeout?.inMilliseconds,
      }),
    );
    if (response.statusCode != 200) {

      print(response.body);

      throw Exception(
        response.body,
      );

    }

    final json = jsonDecode(response.body);

    print("");
    print("===== BACKEND RESPONSE =====");
    print(json);
    print("============================");
    print("");

    return AIResponse(
      reply: json["reply"],
      provider: json["provider"],
      model: json["model"],
    );
  }
}