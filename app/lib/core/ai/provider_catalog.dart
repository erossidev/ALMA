class AIProviderDefinition {
  final String id;
  final String name;
  final String description;
  final bool implemented;

  const AIProviderDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.implemented,
  });
}

class AIProviderCatalog {
  static const providers = [

    AIProviderDefinition(
      id: 'backend',
      name: 'Backend',
      description: 'Backend ALMA',
      implemented: true,
    ),

    AIProviderDefinition(
      id: 'groq',
      name: 'Groq',
      description: 'Groq Cloud API',
      implemented: false,
    ),

    AIProviderDefinition(
      id: 'gemini',
      name: 'Gemini',
      description: 'Google Gemini',
      implemented: false,
    ),

    AIProviderDefinition(
      id: 'openrouter',
      name: 'OpenRouter',
      description: 'OpenRouter API',
      implemented: false,
    ),

    AIProviderDefinition(
      id: 'ollama',
      name: 'Ollama',
      description: 'Local LLM',
      implemented: false,
    ),
  ];

  static List<String> get providerIds =>
      providers.map((e) => e.id).toList();

  static AIProviderDefinition? byId(String id) {
    try {
      return providers.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}