import 'semantic_candidate_source.dart';

class SemanticCandidate {

  final String type;

  final double confidence;

  final String reason;

  final SemanticCandidateSource source;

  const SemanticCandidate({
    required this.type,
    required this.confidence,
    required this.reason,
    required this.source,
  });


}