class SemanticFact {
  final String subject;
  final String predicate;
  final dynamic value;

  const SemanticFact({
    required this.subject,
    required this.predicate,
    required this.value,
  });
}