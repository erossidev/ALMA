import 'dart:convert';

import 'semantic_entity.dart';
import 'semantic_fact.dart';
import 'semantic_relation.dart';
import 'semantic_result.dart';

class SemanticExtractor {
  const SemanticExtractor();

  // =====================================================
  // PARSE JSON -> SEMANTIC RESULT
  // =====================================================

  SemanticResult parse(String jsonString) {
    try {
      final cleaned = _cleanJson(jsonString);

      final json = jsonDecode(cleaned);

      final entities =
          (json["entities"] as List<dynamic>? ?? [])
              .map((e) {
                final entityType =
                    (e["type"] ?? "")
                        .toString()
                        .toLowerCase();

                return SemanticEntity(
                  id: e["id"],
                  label: e["label"],
                  type: SemanticEntityType.values.firstWhere(
                    (t) => t.name == entityType,
                    orElse: () => SemanticEntityType.concept,
                  ),
                );
              })
              .toList();

      final relations =
          (json["relations"] as List<dynamic>? ?? [])
              .map(
                (r) => SemanticRelation(
                  from: r["from"],
                  to: r["to"],
                  relation: r["relation"],
                ),
              )
              .toList();

      final facts =
          (json["facts"] as List<dynamic>? ?? [])
              .map(
                (f) => SemanticFact(
                  subject: f["subject"],
                  predicate: f["predicate"],
                  value: f["value"],
                ),
              )
              .toList();

      return SemanticResult(
        entities: entities,
        relations: relations,
        facts: facts,
      );
    } catch (e) {
      print("=================================");
      print("SEMANTIC PARSER ERROR");
      print(e);
      print("=================================");

      return const SemanticResult(
        entities: [],
        relations: [],
        facts: [],
      );
    }
  }

  // =====================================================
  // PULIZIA OUTPUT LLM
  // =====================================================

  String _cleanJson(String text) {
  print("===== RAW JSON =====");
  print(text);

  var result = text.trim();

  result = result.replaceAll("```json", "");
  result = result.replaceAll("```", "");

  print("===== CLEANED JSON =====");
  print(result);

  return result.trim();
  }
}