import '../../core/ai/ai_manager.dart';

import '../protocol/brain_executor.dart';
import '../protocol/brain_instruction.dart';
import '../protocol/brain_result.dart';

import 'cognitive_memory_manager.dart';
import 'knowledge_model.dart';
import 'knowledge_entity.dart';
import 'knowledge_parser.dart';

import '../ontology/ontology_loader.dart';
import '../ontology/ontology_validator.dart';
import '../ontology/ontology_normalizer.dart';

import '../semantic/learning/semantic_learning_engine.dart';
import '../semantic/learning/semantic_learning_request.dart';
import '../semantic/learning/semantic_proposal.dart';

import '../semantic/resolution/semantic_resolver.dart';

import '../contracts/cognitive_pipeline.dart';

import '../meaning/pipeline/meaning_pipeline.dart';
import '../brain.dart';
import '../semantic/learning/pending_learning.dart';

class KnowledgePipeline implements CognitivePipeline {


  final AIManager aiManager;

  final MeaningPipeline meaningPipeline;

  final BrainExecutor brainExecutor;

  final OntologyNormalizer ontologyNormalizer;

  final SemanticResolver semanticResolver;

  final SemanticLearningEngine semanticLearningEngine;


  final KnowledgeParser knowledgeParser =
      const KnowledgeParser();


  final CognitiveMemoryManager memoryManager =
      const CognitiveMemoryManager();

  final Brain brain;



  KnowledgePipeline({

    required this.aiManager,

    required this.brainExecutor,

    required this.ontologyNormalizer,

    required this.semanticResolver,

    required this.semanticLearningEngine,

    required this.meaningPipeline,

    required this.brain,

});



  @override
  Future<BrainResult> process(
    String message,
  ) async {


    try {


      // =====================================================
      // MEANING PIPELINE
      // =====================================================

      KnowledgeModel knowledge =
          await meaningPipeline.process(
        message,
      );



      // =====================================================
      // ONTOLOGY NORMALIZATION
      // =====================================================

      knowledge =
          await ontologyNormalizer.normalize(
        knowledge,
      );



      print("");
      print("===== KNOWLEDGE =====");

      print(
        "Entities  : ${knowledge.entities.length}",
      );

      print(
        "Relations : ${knowledge.relations.length}",
      );

      print(
        "Facts     : ${knowledge.facts.length}",
      );



      if (knowledge.isEmpty) {

        print(
          "Nessuna conoscenza da memorizzare.",
        );

        return BrainResult.ignored();
      }




      // =====================================================
      // SEMANTIC RESOLUTION
      // ALMA MEMORY FIRST
      // =====================================================


      print("");
      print("===== SEMANTIC RESOLUTION =====");


      final resolvedEntities =
          <KnowledgeEntity>[];



      for (final entity in knowledge.entities) {


        final decision =
            await semanticResolver.resolve(
          entity.label,
        );



        if (decision.known) {


          print(
            "MEMORY HIT: ${entity.label} -> "
            "${decision.semanticType}",
          );



          resolvedEntities.add(
            entity.copyWith(
              semanticType: decision.semanticType,
            ),
          );



        } else {


          print(
            "UNKNOWN ENTITY: ${entity.label}",
          );


          resolvedEntities.add(
            entity,
          );

        }

      }



      knowledge =
          KnowledgeModel(
            entities: resolvedEntities,
            relations: knowledge.relations,
            facts: knowledge.facts,
          );

      print("");
      print("===== AFTER RESOLUTION DEBUG =====");

      for (final e in knowledge.entities) {

        print(
          "${e.label} | "
          "type=${e.type} | "
          "semantic=${e.semanticType}",
        );

      }

print("=================================");

      print("");
      print("===== AFTER SEMANTIC RESOLUTION =====");

      for(final e in knowledge.entities){

        print(
          "${e.label} "
          "type=${e.type} "
          "semantic=${e.semanticType}"
        );

      }

print("=====================================");

      print("");
      print("===== DEBUG SEMANTIC SAVED =====");

      for(final e in knowledge.entities){

        print(
          "${e.label} "
          "TYPE=${e.type} "
          "SEMANTIC=${e.semanticType}"
        );

      }

print("===============================");




      // =====================================================
      // ONTOLOGY VALIDATION
      // =====================================================


      final ontology =
          await OntologyLoader.load();



      final validator =
          OntologyValidator(
            ontology,
          );

    final unresolvedKnowledge =
        KnowledgeModel(
          entities: knowledge.entities
              .where(
                (e) => e.semanticType == null,
              )
              .toList(),
          relations: knowledge.relations,
          facts: knowledge.facts,
        );

    print("");
    print("===== CHECK BEFORE VALIDATOR =====");

    for (final e in knowledge.entities) {

      print(
        "${e.label} "
        "semanticType=${e.semanticType}",
      );

    }

    print("==================================");

    final unknownConcepts =
        validator.validate(
          unresolvedKnowledge,
        );



      print("");
      print("===== ONTOLOGY =====");

      print(
        "Unknown concepts : ${unknownConcepts.length}",
      );


      for (final concept in unknownConcepts) {

        print(
          " - $concept",
        );

      }





      // =====================================================
      // SEMANTIC LEARNING
      // SOLO SE ALMA NON SA
      // =====================================================


      final proposals =
          <SemanticProposal>[];



      for (final concept in unknownConcepts) {


          print(
            "LEARNING UNKNOWN ENTITY: $concept",
          );


          final entity =
              knowledge.entities.firstWhere(
            (e) =>
                e.label.toLowerCase() ==
                concept.toLowerCase(),
          );


          final proposal =
              await semanticLearningEngine.learn(

            SemanticLearningRequest(

              entity: concept,

              text: message,

              type: entity.type,

            ),

          );


          proposals.add(
            proposal,
          );


        }




            // =====================================================
            // DEBUG PROPOSALS
            // =====================================================

            print("");
            print("===== SEMANTIC PROPOSALS =====");


            for (final proposal in proposals) {

              print(
                "${proposal.entity} -> "
                "semantic=${proposal.bestCandidate?.type} "
                "brain=${proposal.bestCandidate?.brainType} "
                "confidence=${proposal.bestCandidate?.confidence}",
              );

            }



            // =====================================================
            // APPLY PROPOSALS
            // =====================================================


            for (final proposal in proposals) {


              final candidate =
                  proposal.bestCandidate;



              // ===============================
              // NESSUN CANDIDATO
              // RICHIESTA CHIARIMENTO
              // ===============================

              if (candidate == null) {


                print(
                  ">>> NECESSARIO CHIARIMENTO: ${proposal.entity}",
                );



                brain.setPendingLearning(

                  PendingLearning(

                    entity:
                        proposal.entity,

                    context:
                        message,

                  ),

                );



                return BrainResult.clarification(

                  question:
                      "Non conosco '${proposal.entity}'. Che tipo di elemento è?",

                  proposal:
                      proposal,

                  reason:
                      "Unknown semantic entity",

                );

              }





              final index =
                  knowledge.entities.indexWhere(

                (entity) =>

                    entity.label.toLowerCase() ==
                    proposal.entity.toLowerCase(),

              );



              if (index == -1) {

                continue;

              }




              knowledge.entities[index] =

                  knowledge.entities[index].copyWith(

                    type:
                        candidate.type,

                    semanticType:
                        candidate.type,

                  );

            }





            // =====================================================
            // BUILD BRAIN INSTRUCTION
            // =====================================================


            final BrainInstruction instruction =

                await memoryManager.build(

                  knowledge:
                      knowledge,

                  proposals:
                      proposals,

                );




            print("");

            print("===== BRAIN =====");


            print(
              "Operation : ${instruction.operation}",
            );





                  // =====================================================
      // EXECUTION
      // =====================================================


      return await brainExecutor.execute(
        instruction,
      );


    } catch (e, stackTrace) {


      print("");

      print(
        "===== KNOWLEDGE PIPELINE ERROR =====",
      );


      print(e);

      print(stackTrace);


      print(
        "====================================",
      );


      return BrainResult.failure(

        BrainOperation.ignore,

        e.toString(),

      );

    }

  }

}