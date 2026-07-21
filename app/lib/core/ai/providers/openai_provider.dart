import 'dart:convert';

import 'package:http/http.dart' as http;

import '../ai_provider.dart';
import '../ai_response.dart';

class OpenAIProvider implements AIProvider {
  @override
  Future<AIResponse> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:3000/chat"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "message": message,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AIResponse.fromJson(data);
      } else {
        return AIResponse(
          reply: "Errore ${response.statusCode}: ${response.body}",
          provider: "Sistema",
          model: "",
        );
      }
    } catch (e) {
      return AIResponse(
        reply: "Errore di connessione: $e",
        provider: "Sistema",
        model: "",
      );
    }
  }
}