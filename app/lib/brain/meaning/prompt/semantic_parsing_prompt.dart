import 'semantic_parsing_request.dart';

class SemanticParsingPrompt {
  const SemanticParsingPrompt();

  String build(
    SemanticParsingRequest request,
  ) {
    return '''
You are a semantic parser.

Extract the semantic meaning of the user's message.

Return ONLY valid JSON.

The JSON MUST have exactly this structure:

{
  "version": 1,
  "entities": [
    {
      "id": "e1",
      "text": "Mario"
    }
  ],
  "propositions": [
    {
      "subject": "speaker",
      "predicate": "likes",
      "object": "e1"
    }
  ]
}

Rules:

- Return ONLY JSON.
- Do not use markdown.
- Do not explain.
- "version" is mandatory.
- "entities" is mandatory.
- "propositions" is mandatory.
- Entity ids must be e1, e2, e3...
- The subject can be:
  - speaker
  - e1
  - e2
  ...
- If the object is an entity, reference its id.
- If the object is a literal value, write the literal.

INPUT

${request.message}
''';
  }
}