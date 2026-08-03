import 'ai_usage.dart';

class AIResponse {
  final String reply;
  final String provider;
  final String model;

  final AIUsage usage;

  AIResponse({
    required this.reply,
    required this.provider,
    required this.model,
    AIUsage? usage,
  }) : usage = usage ?? AIUsage.empty();

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      reply: json["reply"] ?? "",
      provider: json["provider"] ?? "Sconosciuto",
      model: json["model"] ?? "",
      usage: AIUsage.fromJson(json["usage"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "reply": reply,
      "provider": provider,
      "model": model,
      "usage": usage.toJson(),
    };
  }
}