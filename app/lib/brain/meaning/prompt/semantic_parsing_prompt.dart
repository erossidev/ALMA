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

- Separare il nome dell'entità dalla sua categoria.
- Esempio:
  "La stampante Ender"
  deve diventare:
  text: "Ender"
  type: "stampante"

- Il tipo descrive la categoria, non fa parte del nome.


The JSON MUST have exactly this structure:



{
  "version": 1,
    "entities": [
  {
    "id": "e1",
    "text": "Ender",
    "type": "stampante"
  }
  ]
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