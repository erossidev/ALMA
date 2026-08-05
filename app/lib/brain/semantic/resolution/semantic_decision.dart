class SemanticDecision {

  final String entity;

  final bool known;

  final String? semanticType;

  final String? brainType;

  final List<String> alternatives;


  const SemanticDecision({
    required this.entity,
    required this.known,
    this.semanticType,
    this.brainType,
    this.alternatives = const [],
  });

}