import 'semantic_candidate.dart';
import 'semantic_proposal_status.dart';

class SemanticProposal {

  /// Entità da apprendere
  final String entity;

  /// Tutti i candidati ordinati
  final List<SemanticCandidate> candidates;

  /// Stato della proposta
  final SemanticProposalStatus status;

  const SemanticProposal({
    required this.entity,
    required this.candidates,
    required this.status,
  });

  /// Miglior candidato
  SemanticCandidate? get bestCandidate =>
      candidates.isEmpty
          ? null
          : candidates.first;

  /// Esistono candidati?
  bool get hasCandidates =>
      candidates.isNotEmpty;

  /// Numero candidati
  int get candidateCount =>
      candidates.length;

}