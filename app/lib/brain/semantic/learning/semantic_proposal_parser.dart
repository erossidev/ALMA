import 'dart:convert';

import 'semantic_candidate.dart';
import 'semantic_candidate_source.dart';
import 'semantic_proposal.dart';
import 'semantic_proposal_status.dart';

class SemanticProposalParser {
  const SemanticProposalParser();

  SemanticProposal parse(
    String jsonText,
  ) {
    final json =
        jsonDecode(jsonText) as Map<String, dynamic>;

    final entity =
        json["entity"] as String? ?? "";

    final rawCandidates =
        (json["candidates"] as List?) ?? [];

    final candidates =
        rawCandidates.map((candidate) {
      final map =
          candidate as Map<String, dynamic>;

      return SemanticCandidate(
        type: map["type"] as String? ?? "unknown",
        confidence:
            (map["confidence"] as num?)
                    ?.toDouble() ??
                0.0,
        reason:
            map["reason"] as String? ?? "",
        source:
            SemanticCandidateSource.llm,
      );
    }).toList();

    return SemanticProposal(
      entity: entity,
      candidates: candidates,
      status: SemanticProposalStatus.proposed,
    );
  }
}