class AIResource {
  final String id;

  final String providerId;

  final String modelId;

  final String displayName;

  final bool enabled;

  final int priority;

  final List<String> capabilities;

  const AIResource({
    required this.id,
    required this.providerId,
    required this.modelId,
    required this.displayName,
    required this.enabled,
    required this.priority,
    this.capabilities = const [],
  });

  factory AIResource.fromJson(
    Map<String, dynamic> json,
  ) {
    return AIResource(
      id: json["id"],
      providerId: json["providerId"],
      modelId: json["modelId"],
      displayName: json["displayName"],
      enabled: json["enabled"],
      priority: json["priority"],
      capabilities:
          List<String>.from(
        json["capabilities"] ?? [],
      ),
    );
  }
}