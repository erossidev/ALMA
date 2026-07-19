import 'dart:convert';

import 'package:http/http.dart' as http;

import '../ai_provider.dart';

class OpenAIProvider implements AIProvider {
  @override
  Future<String> sendMessage(String message) async {
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
        return data["reply"];
      } else {
        return "Errore ${response.statusCode}: ${response.body}";
      }
    } catch (e) {
      return "Errore di connessione: $e";
    }
  }
}