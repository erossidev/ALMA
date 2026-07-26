class BrainEntityPrompt {
  const BrainEntityPrompt._();

  static String build() {
    return '''
==========================
ENTITIES
==========================

Le entities rappresentano i neuroni
del Brain.

Ogni entity deve avere il formato:

{
  "id":"",
  "label":"",
  "type":""
}

Regole:

- id deve essere stabile.
- id identifica univocamente il neurone.
- label deve essere leggibile.
- type deve appartenere al vocabolario.
- Non creare tipi nuovi.
- Non creare entità duplicate.
- Non creare entità inutili.
- Ogni entità deve rappresentare
  un concetto realmente presente
  nel messaggio.

Esempio:

{
  "id":"emanuele",
  "label":"Emanuele",
  "type":"person"
}
''';
  }
}