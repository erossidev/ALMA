import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ai_registry.dart';
import 'ai_resource.dart';

class BackendAIRegistry implements AIRegistry {
  static const _baseUrl = "http://localhost:3000";

  List<AIResource>? _cache;

  Future<Map<String, dynamic>> loadRouting() async {
    final response = await http.get(
      Uri.parse("$_baseUrl/routing"),
    );

    if (response.statusCode != 200) {
      throw Exception("Unable to load routing");
    }

    return Map<String, dynamic>.from(
      jsonDecode(response.body),
    );
  }

  Future<void> saveRouting(
    Map<String, dynamic> routing,
  ) async {
    final response = await http.put(
      Uri.parse("$_baseUrl/routing"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(routing),
    );

    if (response.statusCode != 200) {
      throw Exception("Unable to save routing");
    }
  }

  @override
  Future<List<AIResource>> loadResources() async {
    // Restituisce la cache se già caricata
    if (_cache != null) {
      return _cache!;
    }

    print("===== LOADING AI RESOURCES =====");

    final response = await http.get(
      Uri.parse("$_baseUrl/resources"),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Errore caricamento risorse AI",
      );
    }

    final List<dynamic> json =
        jsonDecode(response.body);

    _cache = json
        .map(
          (e) => AIResource.fromJson(e),
        )
        .toList();

    print(
      "Loaded ${_cache!.length} AI resources.",
    );

    print("===============================");

    return _cache!;
  }

  /// Svuota la cache delle risorse AI.
  void clearCache() {
    _cache = null;
  }
}