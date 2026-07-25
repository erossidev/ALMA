import 'dart:convert';

import '../../core/ai/ai_manager.dart';
import '../../core/ai/ai_response.dart';

import 'semantic_entity.dart';
import 'semantic_entity.dart';
import 'semantic_fact.dart';
import 'semantic_prompt.dart';
import 'semantic_relation.dart';
import 'semantic_result.dart';

class SemanticExtractor {
  final AIManager aiManager;

  SemanticExtractor(this.aiManager);

  Future<SemanticResult> extract(
    String message,
  ) async {
    final prompt =
        SemanticPrompt.build(message);

    final AIResponse response =
    await aiManager.extractKnowledge(prompt);

    try {
      final json =
          jsonDecode(response.reply);

      final entities =
          (json["entities"] as List)
              .map(
                (e) => SemanticEntity(
                  id: e["id"],
                  label: e["label"],
                  type: SemanticEntityType.values
                      .firstWhere(
                    (t) =>
                        t.name ==
                        e["type"],
                    orElse: () =>
                        SemanticEntityType
                            .concept,
                  ),
                ),
              )
              .toList();

      final relations =
          (json["relations"] as List)
              .map(
                (r) => SemanticRelation(
                  from: r["from"],
                  to: r["to"],
                  relation:
                      r["relation"],
                ),
              )
              .toList();

      final facts =
          (json["facts"] as List)
              .map(
                (f) => SemanticFact(
                  subject:
                      f["subject"],
                  predicate:
                      f["predicate"],
                  value: f["value"],
                ),
              )
              .toList();

      return SemanticResult(
        entities: entities,
        relations: relations,
        facts: facts,
      );
    } catch (_) {
      return const SemanticResult(
        entities: [],
        relations: [],
        facts: [],
      );
    }
  }
}