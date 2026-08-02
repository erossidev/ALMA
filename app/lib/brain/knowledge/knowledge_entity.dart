class KnowledgeEntity {
  final String id;

  final String label;

  final String type;

  const KnowledgeEntity({
    required this.id,
    required this.label,
    required this.type,
  });

  KnowledgeEntity copyWith({
  String? id,
  String? label,
  String? type,
}) {
  return KnowledgeEntity(
    id: id ?? this.id,
    label: label ?? this.label,
    type: type ?? this.type,
  );
}
}