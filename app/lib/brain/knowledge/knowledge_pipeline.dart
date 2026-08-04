import '../../core/ai/ai_manager.dart';

import '../protocol/brain_executor.dart';
import '../protocol/brain_instruction.dart';
import '../protocol/brain_result.dart';

import 'cognitive_memory_manager.dart';
import 'knowledge_model.dart';
import 'knowledge_parser.dart';

import '../ontology/ontology_loader.dart';
import '../ontology/ontology_validator.dart';
import '../ontology/ontology_normalizer.dart';

import '../semantic/learning/semantic_learning_engine.dart';
import '../semantic/learning/semantic_learning_request.dart';
import '../semantic/learning/semantic_proposal.dart';

import '../contracts/cognitive_pipeline.dart';

import '../meaning/pipeline/meaning_pipeline.dart';


class KnowledgePipeline implements CognitivePipeline {

  final AIManager aiManager;

  final MeaningPipeline meaningPipeline;

  final BrainExecutor brainExecutor;

  final OntologyNormalizer ontologyNormalizer;

  final KnowledgeParser knowledgeParser =
      const KnowledgeParser();

  final CognitiveMemoryManager memoryManager =
      const CognitiveMemoryManager();

  final SemanticLearningEngine semanticLearningEngine;


  KnowledgePipeline({
    required this.aiManager,
    required this.brainExecutor,
    required this.ontologyNormalizer,
    required this.semanticLearningEngine,
    required this.meaningPipeline,
  });


  @override
  Future<BrainResult> process(
    String message,
  ) async {

    try {

      // =====================================================
      // MEANING PIPELINE V2
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


      // =====================================================
      // NESSUNA CONOSCENZA
      // =====================================================

      if (knowledge.entities.isEmpty &&
          knowledge.relations.isEmpty &&
          knowledge.facts.isEmpty) {

        print("");
        print("===== KNOWLEDGE =====");
        print("Nessuna conoscenza da memorizzare.");
        print("");

        return BrainResult.ignored();
      }


      // =====================================================
      // ONTOLOGY VALIDATION
      // =====================================================

      final ontology =
          await OntologyLoader.load();


      final validator =
          OntologyValidator(
        ontology,
      );


      final unknownConcepts =
          validator.validate(
        knowledge,
      );


      print("");
      print("===== ONTOLOGY =====");
      print(
        "Unknown concepts : ${unknownConcepts.length}",
      );


      for (final concept in unknownConcepts) {
        print(" - $concept");
      }



      // =====================================================
      // SEMANTIC LEARNING
      // =====================================================

      final proposals =
          <SemanticProposal>[];


      for (final concept in unknownConcepts) {

        final proposal =
            await semanticLearningEngine.learn(
          SemanticLearningRequest(
            entity: concept,
            text: message,
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
          "${proposal.bestCandidate?.type} "
          "(${proposal.bestCandidate?.confidence})",
        );
      }



      // =====================================================
      // BUILD BRAIN INSTRUCTION
      // =====================================================

      final BrainInstruction instruction =
          await memoryManager.build(
        knowledge: knowledge,
        proposals: proposals,
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

      print("");


      return BrainResult.failure(
        BrainOperation.ignore,
        e.toString(),
      );
    }
  }
}