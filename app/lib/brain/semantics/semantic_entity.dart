enum SemanticEntityType {
  person,
  place,
  organization,
  animal,
  object,
  event,
  concept,
}

class SemanticEntity {
  final String id;
  final String label;
  final SemanticEntityType type;

  const SemanticEntity({
    required this.id,
    required this.label,
    required this.type,
  });
}