class BrainRelationPrompt {
  const BrainRelationPrompt._();

  static String build() {
    return '''
==========================
RELATIONS
==========================

Le relations rappresentano
le sinapsi del Brain.

Formato:

{
  "from":"",
  "to":"",
  "type":""
}

Regole:

- from deve riferirsi
  ad una entity esistente.

- to deve riferirsi
  ad una entity esistente.

- type deve appartenere
  al vocabolario.

- Non inventare tipi.

- Non usare frasi naturali.

- Non creare relazioni
  ridondanti.

Esempio corretto:

{
  "from":"user",
  "to":"emanuele",
  "type":"hasName"
}

Esempio errato:

{
  "from":"user",
  "to":"emanuele",
  "type":"si chiama"
}
''';
  }
}