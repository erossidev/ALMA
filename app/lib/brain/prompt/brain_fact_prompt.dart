class BrainFactPrompt {
  const BrainFactPrompt._();

  static String build() {
    return '''
==========================
FACTS
==========================

I facts rappresentano proprietà
associate ad una entity.

Formato:

{
  "id":"",
  "entityId":"",
  "type":"",
  "value":""
}

Regole:

- entityId deve riferirsi
  ad una entity esistente.

- type deve appartenere
  al vocabolario.

- value contiene
  il valore della proprietà.

- Non creare facts inutili.

- Non duplicare
  informazioni già espresse
  tramite relations.

Esempio:

{
  "id":"email_user",

  "entityId":"user",

  "type":"email",

  "value":"mario@email.it"
}
''';
  }
}