import 'semantic_learning_request.dart';

class SemanticLearningPrompt {

  const SemanticLearningPrompt();

  String build(
    SemanticLearningRequest request,
  ) {

    return '''
You are ALMA Semantic Advisor.

TASK

Classify the following entity.

ENTITY

${request.entity}

CONTEXT

${request.text}

RULES

- Do not invent information.
- Use the context.
- Produce multiple candidates.
- Order candidates by confidence.
- Explain every candidate.
- Return JSON only.

JSON

{
  "candidates": [
    {
      "type": "",
      "confidence": 0.0,
      "reason": ""
    }
  ]
}
''';

  }

}