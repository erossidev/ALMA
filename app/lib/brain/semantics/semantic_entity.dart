enum SemanticEntityType {
  person,
  place,
  organization,
  company,
  project,
  product,
  technology,
  document,
  date,
  event,
  preference,
  goal,
  emotion,
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