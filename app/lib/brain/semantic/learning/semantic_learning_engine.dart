import '../similarity/similarity_candidate.dart';
import '../similarity/similarity_engine.dart';
import '../similarity/similarity_request.dart';

import 'semantic_advisor.dart';
import 'semantic_candidate.dart';
import 'semantic_candidate_source.dart';
import 'semantic_learning_request.dart';
import 'semantic_proposal.dart';
import 'semantic_proposal_status.dart';

class SemanticLearningEngine {

  final SemanticAdvisor advisor;

  final SimilarityEngine similarityEngine;

  const SemanticLearningEngine({
    required this.advisor,
    required this.similarityEngine,
  });

  Future<SemanticProposal> learn(
    SemanticLearningRequest request,
  ) async {

    // ==========================
    // CERCA NEL SEMANTIC CORTEX
    // ==========================

    final similarity =
        await similarityEngine.classify(
      SimilarityRequest(
        entity: request.entity,
        context: request.text,
      ),
    );

    // ==========================
    // MATCH TROVATI
    // ==========================

    if (similarity.isNotEmpty) {

      final candidates =
          similarity.candidates.map(
        (SimilarityCandidate candidate) {

          return SemanticCandidate(
            type: candidate.node.type.name,
            confidence: candidate.score,
            reason:
                "Similarity match",
            source:
                SemanticCandidateSource.similarity,
          );

        },
      ).toList();

      return SemanticProposal(
        entity: request.entity,
        candidates: candidates,
        status:
            SemanticProposalStatus.proposed,
      );
    }

    // ==========================
    // NESSUN MATCH
    // CHIEDE ALL'AI
    // ==========================

    return await advisor.advise(
      request,
    );

  }

}