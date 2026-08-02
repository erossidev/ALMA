import 'ontology_prompt_builder.dart';

class OntologyNormalizationPrompt {
  const OntologyNormalizationPrompt();

  static Future<String> build(
    String knowledgeJson,
  ) async {

    final ontologyPrompt =
        await OntologyPromptBuilder.build();

    return '''
Sei il normalizzatore dell'ontologia di ALMA.

NON estrarre nuova conoscenza.

NON creare nuove entità.

NON eliminare entità.

NON modificare il significato.

NON correggere errori.

Il tuo unico compito è normalizzare i concetti presenti nel JSON utilizzando ESCLUSIVAMENTE i concept ID dell'ontologia.

================================================================
ONTOLOGIA
================================================================

$ontologyPrompt

================================================================
REGOLE
================================================================

Puoi modificare ESCLUSIVAMENTE:

- entities.type
- relations.type
- facts.type

NON modificare MAI:

- entities.id
- entities.label
- relations.from
- relations.to
- facts.id
- facts.entityId
- facts.value

Se un tipo, una relazione o un fatto corrisponde ad un concetto
presente nell'ontologia, sostituiscilo con l'ID esatto.

Se non trovi alcuna corrispondenza,
lascia il valore invariato.

NON aggiungere nuove informazioni.

NON eliminare informazioni.

NON aggiungere spiegazioni.

NON usare markdown.

================================================================
GESTIONE DI "unknown"
================================================================

Se entities.type è uguale a "unknown":

- NON modificarlo.
- NON inferire il tipo corretto.
- NON usare conoscenza generale.
- NON sostituirlo con company, product, person, place o qualsiasi altro tipo.

"unknown" è un valore valido e deve rimanere invariato.

La classificazione semantica verrà eseguita successivamente dal Brain di ALMA.

Qualsiasi modifica di "unknown" costituisce un errore.

ESEMPIO

INPUT

{
  "entities": [
    {
      "label": "Tesla",
      "type": "unknown"
    }
  ]
}

OUTPUT

{
  "entities": [
    {
      "label": "Tesla",
      "type": "unknown"
    }
  ]
}

================================================================
JSON DA NORMALIZZARE
================================================================

$knowledgeJson

================================================================
OUTPUT
================================================================

Restituisci ESATTAMENTE lo stesso JSON.

L'unica differenza consentita è l'eventuale modifica di:

- entities.type
- relations.type
- facts.type

Tutto il resto deve rimanere IDENTICO.
''';
  }
}