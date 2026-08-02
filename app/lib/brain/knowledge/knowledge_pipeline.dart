import '../../core/ai/ai_manager.dart';
import '../protocol/brain_executor.dart';
import '../protocol/brain_instruction.dart';
import '../protocol/brain_result.dart';
import 'cognitive_memory_manager.dart';
import 'knowledge_model.dart';
import 'knowledge_parser.dart';
import 'knowledge_extraction_prompt.dart';
import '../ontology/ontology_loader.dart';
import '../ontology/ontology_validator.dart';
import '../ontology/ontology_normalizer.dart';
import '../semantic/learning/semantic_learning_engine.dart';
import '../semantic/learning/semantic_learning_request.dart';
import '../semantic/learning/semantic_proposal.dart';


class KnowledgePipeline {
  final AIManager aiManager;

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
  });

  Future<BrainResult> process(
    String message,
  ) async {
    // =====================================================
    // COSTRUZIONE PROMPT
    // =====================================================

    final prompt =
      await KnowledgeExtractionPrompt.build(
    message,
  );

    print("");
    print("===== KNOWLEDGE PROMPT =====");
    print(prompt);

    // =====================================================
    // AI
    // =====================================================

    final rawJson =
        await aiManager.extractKnowledge(
      prompt,
    );

    print("");
    print("===== KNOWLEDGE JSON =====");
    print(rawJson);

    final json = rawJson
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    try {
      // ===================================================
      // KNOWLEDGE PARSER
      // ===================================================

      KnowledgeModel knowledge =
          knowledgeParser.parse(
        json,
      );

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

      // ===================================================
      // NESSUNA CONOSCENZA
      // ===================================================

      if (knowledge.entities.isEmpty &&
          knowledge.relations.isEmpty &&
          knowledge.facts.isEmpty) {
        print("");
        print("===== KNOWLEDGE =====");
        print("Nessuna conoscenza da memorizzare.");
        print("");

        return BrainResult.ignored();
      }

      // ===================================================
      // ONTOLOGY
      // ===================================================

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

      for (final concept
          in unknownConcepts) {
        print(" - $concept");
      }

      // ===================================================
      // SEMANTIC LEARNING
      // ===================================================

      final proposals = <SemanticProposal>[];

      for (final concept in unknownConcepts) {
        final proposal =
            await semanticLearningEngine.learn(
          SemanticLearningRequest(
            entity: concept,
            text: message,
          ),
        );

        proposals.add(proposal);
      }
    // ===================================================
    // APPLY SEMANTIC PROPOSALS
    // ===================================================

    for (final proposal in proposals) {

      final candidate = proposal.bestCandidate;

      if (candidate == null) {
        continue;
      }

      print("CERCO: '${proposal.entity}'");

      for (final entity in knowledge.entities) {
        print(
          "ENTITY: id='${entity.id}' label='${entity.label}' type='${entity.type}'",
        );
      }

      final index = knowledge.entities.indexWhere(
        (entity) =>
            entity.id.toLowerCase() ==
                proposal.entity.toLowerCase() ||
            entity.label.toLowerCase() ==
                proposal.entity.toLowerCase(),
      );

      print("INDEX TROVATO = $index");

      if (index == -1) {
        continue;
      }

      knowledge.entities[index] =
          knowledge.entities[index].copyWith(
        type: candidate.type,
      );

      print(
        "UPDATE: ${knowledge.entities[index].label} -> ${knowledge.entities[index].type}",
      );
    }

    print("");
    print("===== SEMANTIC PROPOSALS =====");

    for (final proposal in proposals) {
    print(
      "${proposal.entity} -> ${proposal.bestCandidate?.type} (${proposal.bestCandidate?.confidence})",
    );
  }
  
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

      // ===================================================
      // EXECUTION
      // ===================================================

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