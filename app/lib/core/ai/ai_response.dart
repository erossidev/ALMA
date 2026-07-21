class AIResponse {
  final String reply;
  final String provider;
  final String model;

  AIResponse({
    required this.reply,
    required this.provider,
    required this.model,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      reply: json["reply"] ?? "",
      provider: json["provider"] ?? "Sconosciuto",
      model: json["model"] ?? "",
    );
  }
}