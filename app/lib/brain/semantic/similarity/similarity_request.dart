class SimilarityRequest {

  /// Entità da classificare
  final String entity;

  /// Contesto in cui è stata trovata
  final String context;

  const SimilarityRequest({
    required this.entity,
    required this.context,
  });

}