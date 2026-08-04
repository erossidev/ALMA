import '../../knowledge/model/knowledge_entity.dart';
import '../../knowledge/model/knowledge_fact.dart';
import '../../knowledge/model/knowledge_model.dart';
import '../../knowledge/model/knowledge_relation.dart';

import '../model/meaning.dart';
import '../model/meaning_entity.dart';
import '../model/meaning_proposition.dart';

class MeaningInterpreter {
  const MeaningInterpreter();

  KnowledgeModel interpret(
    Meaning meaning,
  ) {
    final entities = _buildEntities(
      meaning.entities,
    );

    final relations = _buildRelations(
      meaning.propositions,
    );

    final facts = _buildFacts(
      meaning.propositions,
    );

    return KnowledgeModel(
      entities: entities,
      relations: relations,
      facts: facts,
    );
  }

  List<KnowledgeEntity> _buildEntities(
    List<MeaningEntity> entities,
  ) {
    return entities
        .map(
          (entity) => KnowledgeEntity(
            id: entity.id,
            label: entity.text,
            type: 'unknown',
          ),
        )
        .toList();
  }

  List<KnowledgeRelation> _buildRelations(
    List<MeaningProposition> propositions,
  ) {
    final relations = <KnowledgeRelation>[];

    for (final proposition in propositions) {
      if (_isEntityReference(proposition.object)) {
        relations.add(
          KnowledgeRelation(
            from: proposition.subject,
            to: proposition.object,
            type: proposition.predicate,
          ),
        );
      }
    }

    return relations;
  }

  List<KnowledgeFact> _buildFacts(
    List<MeaningProposition> propositions,
  ) {
    final facts = <KnowledgeFact>[];

    var id = 0;

    for (final proposition in propositions) {
      if (!_isEntityReference(proposition.object)) {
        facts.add(
          KnowledgeFact(
            id: 'fact_${id++}',
            entityId: proposition.subject,
            type: proposition.predicate,
            value: proposition.object,
          ),
        );
      }
    }

    return facts;
  }

  bool _isEntityReference(
    String value,
  ) {
    return value == 'speaker' ||
        value.startsWith('e');
  }
}