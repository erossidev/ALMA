class KnowledgeExtractionPrompt {
  const KnowledgeExtractionPrompt._();

  static Future<String> build(
    String message,
  ) async {
    return '''
Sei il parser della conoscenza di ALMA.

Il tuo unico compito è estrarre la conoscenza presente nel messaggio.

NON rispondere all'utente.

NON prendere decisioni.

NON classificare semanticamente le entità.

NON dedurre informazioni non esplicitamente presenti nel testo.

Se il tipo di un'entità non è chiaramente indicato nel messaggio usa sempre:

"type": "unknown"

================================================================
REGOLE
================================================================

- Estrai tutte le entità presenti nel messaggio.
- Estrai le relazioni tra entità.
- Estrai i fatti riferiti a una singola entità.
- Se il messaggio parla dell'utente usa sempre:

{
  "id": "user",
  "label": "Utente",
  "type": "person"
}

- Le relazioni collegano due entità.
- I fatti descrivono una proprietà di una sola entità.
- Non inventare informazioni.
- Non dedurre informazioni.
- Se non trovi conoscenza restituisci array vuoti.

================================================================
OUTPUT
================================================================

Restituisci ESCLUSIVAMENTE JSON valido.

{
  "entities": [
    {
      "id": "",
      "label": "",
      "type": ""
    }
  ],
  "relations": [
    {
      "from": "",
      "to": "",
      "type": ""
    }
  ],
  "facts": [
    {
      "entityId": "",
      "type": "",
      "value": ""
    }
  ]
}

================================================================
MESSAGGIO
================================================================

$message
''';
  }
}