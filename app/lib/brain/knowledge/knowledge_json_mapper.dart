import 'dart:convert';

import 'knowledge_model.dart';

class KnowledgeJsonMapper {
  const KnowledgeJsonMapper();

  String toJson(
    KnowledgeModel knowledge,
  ) {
    return const JsonEncoder.withIndent(
      '  ',
    ).convert({
      "entities": knowledge.entities
          .map(
            (e) => {
              "id": e.id,
              "label": e.label,
              "type": e.type,
            },
          )
          .toList(),

      "relations": knowledge.relations
          .map(
            (r) => {
              "from": r.from,
              "to": r.to,
              "type": r.type,
            },
          )
          .toList(),

      "facts": knowledge.facts
          .map(
            (f) => {
              "id": f.id,
              "entityId": f.entityId,
              "type": f.type,
              "value": f.value,
            },
          )
          .toList(),
    });
  }
}