class SemanticPrompt {
  static String build(String message) {
    return '''
Sei il motore semantico di ALMA.

Analizza il messaggio dell'utente ed estrai SOLO informazioni permanenti.

Restituisci ESCLUSIVAMENTE un JSON valido.

Formato:

{
  "entities":[
    {
      "id":"",
      "label":"",
      "type":""
    }
  ],
  "relations":[
    {
      "from":"",
      "to":"",
      "relation":""
    }
  ],
  "facts":[
    {
      "subject":"",
      "predicate":"",
      "value":""
    }
  ]
}

Regole:

- Non aggiungere testo.
- Non spiegare.
- Nessun markdown.
- Solo JSON.
- Se non trovi informazioni permanenti restituisci liste vuote.

Messaggio:

$message
''';
  }
}