import '../neuron.dart';

import 'concept.dart';

class ConceptExtractor {
  List<Concept> extract(String message) {
    final concepts = <Concept>[];

    final lower = message.toLowerCase();

    if (lower.startsWith('mi chiamo ')) {
      final name = message.substring(10).trim();

      concepts.add(
        const Concept(
          id: 'user',
          label: 'Utente',
          type: NodeType.person,
        ),
      );

      concepts.add(
        Concept(
          id: name.toLowerCase(),
          label: name,
          type: NodeType.person,
        ),
      );
    }

    return concepts;
  }
}