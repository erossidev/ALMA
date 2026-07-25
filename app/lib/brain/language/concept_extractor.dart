import '../neuron.dart';

import 'concept.dart';
import '../brain_vocabulary.dart';

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
          type: EntityType.person,
        ),
      );

      concepts.add(
        Concept(
          id: name.toLowerCase(),
          label: name,
          type: EntityType.person,
        ),
      );
    }

    return concepts;

    final RelationshipType relationship;
    
  }
}