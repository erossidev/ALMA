import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ai_registry.dart';
import 'ai_resource.dart';

class BackendAIRegistry implements AIRegistry {

  static const _baseUrl =
      "http://localhost:3000";

  @override
  Future<List<AIResource>> loadResources() async {

    final response =
        await http.get(
      Uri.parse("$_baseUrl/resources"),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Errore caricamento risorse AI",
      );
    }

    final List<dynamic> json =
        jsonDecode(response.body);

    return json
        .map(
          (e) =>
              AIResource.fromJson(e),
        )
        .toList();
  }
}