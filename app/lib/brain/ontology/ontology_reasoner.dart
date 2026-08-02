import '../semantic/learning/semantic_learning_engine.dart';
import '../semantic/learning/semantic_learning_request.dart';

import 'semantic_to_ontology_adapter.dart';

class OntologyHypothesis {
  final String unknownConcept;

  final String? candidate;

  final double confidence;

  const OntologyHypothesis({
    required this.unknownConcept,
    required this.candidate,
    required this.confidence,
  });
}

class OntologyReasoner {

  final SemanticLearningEngine semanticLearningEngine;

  final SemanticToOntologyAdapter adapter =
      const SemanticToOntologyAdapter();

  const OntologyReasoner({
    required this.semanticLearningEngine,
  });

  Future<List<OntologyHypothesis>> reason({
    required List<String> unknownConcepts,
    required String context,
  }) async {

    final hypotheses = <OntologyHypothesis>[];

    for (final concept in unknownConcepts) {

      final proposal =
          await semanticLearningEngine.learn(
        SemanticLearningRequest(
          entity: concept,
          text: context,
        ),
      );

      hypotheses.add(
        adapter.adapt(
          proposal,
        ),
      );
    }

    return hypotheses;
  }

}