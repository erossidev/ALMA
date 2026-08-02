import 'similarity_candidate.dart';

class SimilarityResult {

  /// Candidati ordinati dal migliore al peggiore
  final List<SimilarityCandidate> candidates;

  const SimilarityResult({
    required this.candidates,
  });

  /// Nessun candidato trovato
  bool get isEmpty => candidates.isEmpty;

  /// Esiste almeno un candidato
  bool get isNotEmpty => candidates.isNotEmpty;

  /// Miglior candidato
  SimilarityCandidate? get best =>
      isEmpty ? null : candidates.first;

}