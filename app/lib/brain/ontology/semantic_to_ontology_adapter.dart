import '../semantic/learning/semantic_proposal.dart';

import 'ontology_reasoner.dart';

class SemanticToOntologyAdapter {
  const SemanticToOntologyAdapter();

  OntologyHypothesis adapt(
    SemanticProposal proposal,
  ) {
    if (proposal.candidates.isEmpty) {
      return OntologyHypothesis(
        unknownConcept: proposal.entity,
        candidate: null,
        confidence: 0,
      );
    }

    final best = proposal.candidates.first;

    return OntologyHypothesis(
      unknownConcept: proposal.entity,
      candidate: best.type,
      confidence: best.confidence,
    );
  }
}