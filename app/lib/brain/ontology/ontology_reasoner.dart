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
  const OntologyReasoner();

  Future<List<OntologyHypothesis>> reason({
    required List<String> unknownConcepts,
  }) async {
    // Per ora nessun ragionamento.
    // Arriverà nel prossimo step tramite AI.

    return unknownConcepts
        .map(
          (c) => OntologyHypothesis(
            unknownConcept: c,
            candidate: null,
            confidence: 0,
          ),
        )
        .toList();
  }
}