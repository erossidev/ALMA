import 'dart:convert';

import '../protocol/brain_instruction.dart';
import 'knowledge_model.dart';
import '../brain_vocabulary.dart';

class KnowledgeParser {
  const KnowledgeParser();

  KnowledgeModel parse(
    String json,
  ) {
    final Map<String, dynamic> data =
        jsonDecode(json);

    return KnowledgeModel(
      entities: _parseEntities(
        data['entities'],
      ),
      relations: _parseRelations(
        data['relations'],
      ),
      facts: _parseFacts(
        data['facts'],
      ),
    );
  }

  List<BrainEntity> _parseEntities(
    dynamic list,
  ) {
    if (list is! List) {
      return [];
    }

    return list.map<BrainEntity>((item) {
      return BrainEntity(
        id: item['id'],
        label: item['label'],
        type: EntityType.values.firstWhere(
          (e) => e.name == item['type'],
          orElse: () => EntityType.concept,
        ),
      );
    }).toList();
  }

  List<BrainRelation> _parseRelations(
    dynamic list,
  ) {
    if (list is! List) {
      return [];
    }

    return list.map<BrainRelation>((item) {
      return BrainRelation(
        from: item['from'],
        to: item['to'],
        type: RelationshipType.values.firstWhere(
          (e) => e.name == item['type'],
          orElse: () => RelationshipType.relatedTo,
        ),
      );
    }).toList();
  }

  List<BrainFact> _parseFacts(
    dynamic list,
  ) {
    if (list is! List) {
      return [];
    }

    return list.map<BrainFact>((item) {
      return BrainFact(
        id: item['id'],
        entityId: item['entityId'],
        type: FactType.values.firstWhere(
          (e) => e.name == item['type'],
          orElse: () => FactType.note,
        ),
        value: item['value'],
      );
    }).toList();
  }
}