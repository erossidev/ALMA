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

    final cleaned = jsonText
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();


    final json =
        jsonDecode(cleaned) as Map<String, dynamic>;



    final entity =
        json["entity"] as String? ?? "";



    // =====================================================
    // SE L'ENTITÀ È SCONOSCIUTA
    // NON ACCETTIAMO PROPOSTE AUTOMATICHE
    // L'APPRENDIMENTO DEVE PASSARE DALL'UTENTE
    // =====================================================

    final known =
        json["known"] as bool? ?? false;


    if (!known) {

      return SemanticProposal(

        entity: entity,

        candidates:
            const [],

        status:
            SemanticProposalStatus.proposed,

      );

    }




    // =====================================================
    // BRAIN TYPE GLOBALE
    // =====================================================

    final brainType =
        json["brainType"] as String? ??
        "unknown";




    final rawCandidates =
        (json["candidates"] as List?) ?? [];




    final candidates =
        rawCandidates
            .map((candidate) {


          final map =
              candidate as Map<String, dynamic>;



          final confidence =
              (map["confidence"] as num?)
                  ?.toDouble() ??
              0.0;



          // =================================================
          // FILTRO SICUREZZA
          // UNA PROPOSTA LLM NON È CONOSCENZA
          // =================================================

          if (confidence < 0.85) {

            return null;

          }




          return SemanticCandidate(

            type:
                map["type"] as String? ??
                "unknown",


            brainType:
                brainType,


            confidence:
                confidence,


            reason:
                map["reason"] as String? ??
                "LLM suggestion",


            source:
                SemanticCandidateSource.llm,

          );


        })
        .whereType<SemanticCandidate>()
        .toList();





    return SemanticProposal(

      entity:
          entity,


      candidates:
          candidates,


      status:
          SemanticProposalStatus.proposed,

    );

  }

}