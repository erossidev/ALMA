class AIUsage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  final int responseTimeMs;

  final String finishReason;

  const AIUsage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
    required this.responseTimeMs,
    required this.finishReason,
  });

  factory AIUsage.empty() {
    return const AIUsage(
      promptTokens: 0,
      completionTokens: 0,
      totalTokens: 0,
      responseTimeMs: 0,
      finishReason: "unknown",
    );
  }

  factory AIUsage.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AIUsage.empty();
    }

    return AIUsage(
      promptTokens: json["promptTokens"] ?? 0,
      completionTokens: json["completionTokens"] ?? 0,
      totalTokens: json["totalTokens"] ?? 0,
      responseTimeMs: json["responseTimeMs"] ?? 0,
      finishReason: json["finishReason"] ?? "unknown",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "promptTokens": promptTokens,
      "completionTokens": completionTokens,
      "totalTokens": totalTokens,
      "responseTimeMs": responseTimeMs,
      "finishReason": finishReason,
    };
  }
}