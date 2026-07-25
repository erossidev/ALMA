import '../synapse.dart';

import 'extracted_relation.dart';

class RelationExtractor {
  List<ExtractedRelation> extract(String message) {
    final relations = <ExtractedRelation>[];

    final lower = message.toLowerCase();

    if (lower.startsWith('mi chiamo ')) {
      final name = message.substring(10).trim();

      relations.add(
        ExtractedRelation(
          from: 'user',
          to: name.toLowerCase(),
          relationship: RelationshipType.hasName,
        ),
      );
    }

    return relations;
  }
}