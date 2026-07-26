class BrainOutputPrompt {
  const BrainOutputPrompt._();

  static String build() {
    return '''
==========================
OUTPUT
==========================

Rispondi esclusivamente con JSON valido.

Non usare:

- markdown
- blocchi ```json
- testo aggiuntivo

Formato obbligatorio:

{
  "version":1,

  "operation":"",

  "memoryType":"",

  "confidence":0.0,

  "importance":0.0,

  "reason":"",

  "question":"",

  "entities":[],

  "relations":[],

  "facts":[]
}
''';
  }
}