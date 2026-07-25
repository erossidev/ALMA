import 'dart:convert';

import 'learning_decision.dart';

class LearningExtractor {
  const LearningExtractor();

  LearningDecision parse(
    String jsonString,
  ) {
    try {
      final cleaned = _cleanJson(jsonString);

      final json = jsonDecode(cleaned);

      return LearningDecision(
        shouldLearn:
            json["shouldLearn"] ?? false,

        reason:
            json["reason"] ?? "",
      );
    } catch (e) {
      print("=================================");
      print("LEARNING PARSER ERROR");
      print(e);
      print("=================================");

      return const LearningDecision(
        shouldLearn: false,
        reason: "parse_error",
      );
    }
  }

  String _cleanJson(String text) {
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');

    if (start == -1 || end == -1) {
      return text.trim();
    }

    return text.substring(
      start,
      end + 1,
    );
  }
}