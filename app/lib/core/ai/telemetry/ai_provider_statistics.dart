class AIProviderStatistics {
  final String providerId;

  int requests;

  int promptTokens;

  int completionTokens;

  int totalTokens;

  int totalResponseTimeMs;

  int errors;

  AIProviderStatistics({
    required this.providerId,
    this.requests = 0,
    this.promptTokens = 0,
    this.completionTokens = 0,
    this.totalTokens = 0,
    this.totalResponseTimeMs = 0,
    this.errors = 0,
  });

  double get averageResponseTime {
    if (requests == 0) return 0;
    return totalResponseTimeMs / requests;
  }

  void add({
    required int prompt,
    required int completion,
    required int total,
    required int responseTimeMs,
  }) {
    requests++;

    promptTokens += prompt;
    completionTokens += completion;
    totalTokens += total;

    totalResponseTimeMs += responseTimeMs;
  }
}