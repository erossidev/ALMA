class BrainFactPrompt {
  const BrainFactPrompt._();

  static String build() {
    return '''
==========================
FACTS
==========================

I Facts rappresentano proprietà
associate ad una singola entità.

Un Fact NON rappresenta una relazione
tra due entità.

Usa i Facts solamente per proprietà
intrinseche dell'entità.

Formato obbligatorio:

{
  "id":"",
  "entityId":"",
  "type":"",
  "value":""
}

Regole:

- entityId deve riferirsi ad una entity esistente.

- type deve appartenere esclusivamente
  al vocabolario dei FactType.

- value contiene il valore della proprietà.

- Non creare Facts duplicati.

- Non creare Facts inutili.

- Non usare Facts per rappresentare
  relazioni tra entità.

Le seguenti informazioni devono essere
rappresentate come Facts:

- age
- birthday
- email
- phone
- profession
- language
- nationality
- gender
- website
- note

NON utilizzare i Facts per:

- parentela
- matrimonio
- amicizia
- luogo di nascita
- luogo di lavoro
- possesso
- preferenze

Queste devono essere rappresentate
tramite Relations.

Esempi corretti:

{
  "id":"michela_age",
  "entityId":"michela",
  "type":"age",
  "value":"49"
}

{
  "id":"user_email",
  "entityId":"user",
  "type":"email",
  "value":"mario@email.it"
}

{
  "id":"user_profession",
  "entityId":"user",
  "type":"profession",
  "value":"Ingegnere"
}
''';
  }
}