class AIRequest {
  final String prompt;

  /// Cosa serve per questa richiesta
  final List<String> requiredCapabilities;

  const AIRequest({
    required this.prompt,
    this.requiredCapabilities = const [],
  });
}