import 'dart:convert';

import 'package:http/http.dart' as http;

import 'ai_provider.dart';
import 'providers/backend_ai_provider.dart';


class AIProviderRegistry {

  static const String _baseUrl =
      "http://localhost:3000";


  final Map<String, AIProvider> _providers = {};


  AIProviderRegistry();


  Future<void> loadProviders() async {

    final response =
        await http.get(
          Uri.parse(
            "$_baseUrl/providers",
          ),
        );


    if (response.statusCode != 200) {

      throw Exception(
        "Unable to load AI providers",
      );

    }


    final List<dynamic> data =
        jsonDecode(response.body);



    for (final item in data) {

      final id =
          item["id"];


      if (id == "groq" ||
          id == "gemini" ||
          id == "openrouter" ||
          id == "ollama") {


        // Temporaneo:
        // colleghiamo tutti al provider backend
        _providers[id] =
            BackendAIProvider();

      }

    }

  }



  AIProvider getProvider(
    String providerId,
  ) {

    final provider =
        _providers[providerId];


    if (provider == null) {

      throw Exception(
        'Unknown AI provider: $providerId',
      );

    }


    return provider;

  }



  List<String> get providerIds =>
      _providers.keys.toList();



  List<String> getAvailableProviders() =>
      providerIds;



  int get count =>
      _providers.length;

}