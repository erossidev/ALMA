import '../semantic_cortex.dart';

import 'similarity_candidate.dart';
import 'similarity_request.dart';
import 'similarity_result.dart';

double _calculateScore() {

  // TODO:
  // Algoritmo di Similarity.

  return 0;

}

List<SimilarityCandidate> _sortCandidates(
  List<SimilarityCandidate> candidates,
) {

  candidates.sort(
    (a, b) => b.score.compareTo(a.score),
  );

  return candidates;

}

class SimilarityEngine {

  final SemanticCortex cortex;

  const SimilarityEngine({
    required this.cortex,
  });

  Future<SimilarityResult> classify(
    SimilarityRequest request,
  ) async {

    final candidates =
        <SimilarityCandidate>[];

    // TODO:
    // 1. Analizzare il contesto
    // 2. Confrontare con il SemanticCortex
    // 3. Calcolare gli score
    // 4. Ordinare i candidati

    return SimilarityResult(
      candidates: candidates,
    );

  }

}