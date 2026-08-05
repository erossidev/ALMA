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


  static const double similarityThreshold = 0.85;



  const SemanticLearningEngine({

    required this.advisor,

    required this.similarityEngine,

  });





  Future<SemanticProposal> learn(

    SemanticLearningRequest request,

  ) async {



    // =====================================================
    // 1) TIPO GIÀ ESTRATTO DAL MEANING PIPELINE
    // =====================================================
    //
    // Esempio:
    //
    // XENOFIL
    // type = material
    //
    // Non serve similarity.
    // Non serve chiedere all'utente.
    //
    // =====================================================


    if (request.type != null &&
        request.type!.trim().isNotEmpty) {



      print(
        "DIRECT TYPE MATCH: "
        "${request.entity} -> ${request.type}",
      );



      return SemanticProposal(

        entity:
            request.entity,


        candidates: [

          SemanticCandidate(

            type:
                request.type!,


            brainType:
                request.type!,


            confidence:
                0.90,


            reason:
                "Meaning extracted type",


            source:
                SemanticCandidateSource.llm,

          ),

        ],


        status:
            SemanticProposalStatus.proposed,

      );

    }







    // =====================================================
    // 2) CERCA NELLA MEMORIA SEMANTICA
    // =====================================================


    final similarity =

        await similarityEngine.classify(

      SimilarityRequest(

        entity:
            request.entity,


        context:
            request.entity,

      ),

    );





    print(
      "===== SIMILARITY DEBUG =====",
    );


    for (final candidate
        in similarity.candidates) {


      print(

        "${candidate.node.label} "
        "score=${candidate.score} "
        "type=${candidate.node.type.name} "
        "brain=${candidate.node.metadata.brainType}",

      );

    }


    print(
      "============================",
    );







    // =====================================================
    // 3) MATCH SICURO
    // =====================================================


    if (similarity.isNotEmpty &&

        similarity.candidates.first.score >=
            similarityThreshold) {



      final candidates =

          similarity.candidates

              .where(

                (c) =>
                    c.score >=
                    similarityThreshold,

              )

              .map(

        (SimilarityCandidate candidate) {



          return SemanticCandidate(

            type:

                candidate.node.type.name,


            brainType:

                candidate.node.metadata.brainType ??
                "unknown",


            confidence:

                candidate.score,


            reason:

                "Similarity match",


            source:

                SemanticCandidateSource.similarity,

          );


        },

      )

      .toList();







      return SemanticProposal(

        entity:

            request.entity,


        candidates:

            candidates,


        status:

            SemanticProposalStatus.proposed,

      );

    }








    // =====================================================
    // 4) NESSUNA CONOSCENZA
    // =====================================================


    print(
      "NO SEMANTIC MATCH FOR ${request.entity}",
    );



    return SemanticProposal(

      entity:

          request.entity,


      candidates:

          const [],


      status:

          SemanticProposalStatus.proposed,

    );



  }

}