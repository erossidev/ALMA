class Meaning {
  final String version;
  final String language;
  final List<MeaningEntity> entities;
  final List<MeaningProposition> propositions;
  final MeaningMetadata metadata;

  const Meaning({
    required this.version,
    required this.language,
    required this.entities,
    required this.propositions,
    required this.metadata,
  });
}