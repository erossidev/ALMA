import 'dart:convert';

import 'knowledge_entity.dart';
import 'knowledge_fact.dart';
import 'knowledge_model.dart';
import 'knowledge_relation.dart';

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

  List<KnowledgeEntity> _parseEntities(
    dynamic list,
  ) {
    if (list is! List) {
      return [];
    }

    return list.map<KnowledgeEntity>((item) {
      return KnowledgeEntity(
        id: (item['id'] ?? '').toString(),
        label: (item['label'] ?? '').toString(),
        type: (item['type'] ?? '').toString(),
      );
    }).toList();
  }

  List<KnowledgeRelation> _parseRelations(
    dynamic list,
  ) {
    if (list is! List) {
      return [];
    }

    return list.map<KnowledgeRelation>((item) {
      return KnowledgeRelation(
        from: (item['from'] ?? '').toString(),
        to: (item['to'] ?? '').toString(),
        type: (item['type'] ?? '').toString(),
      );
    }).toList();
  }

  List<KnowledgeFact> _parseFacts(
    dynamic list,
  ) {
    if (list is! List) {
      return [];
    }

    return list.map<KnowledgeFact>((item) {
      return KnowledgeFact(
        id: (item['id'] ?? '').toString(),
        entityId: (item['entityId'] ?? '').toString(),
        type: (item['type'] ?? '').toString(),
        value: (item['value'] ?? '').toString(),
      );
    }).toList();
  }
}