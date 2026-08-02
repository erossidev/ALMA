import '../semantic_node.dart';

class SimilarityCandidate {

  /// Nodo proposto
  final SemanticNode node;

  /// Punteggio di similarità
  final double score;

  const SimilarityCandidate({
    required this.node,
    required this.score,
  });

}