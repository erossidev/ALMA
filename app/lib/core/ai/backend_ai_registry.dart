import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ai_registry.dart';
import 'ai_resource.dart';

class BackendAIRegistry implements AIRegistry {
  static const _baseUrl = "http://localhost:3000";

  List<AIResource>? _cache;

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

  /// Da usare se in futuro il backend modifica
  /// la configurazione delle AI e vuoi ricaricarla.
  void clearCache() {
    _cache = null;
  }
}