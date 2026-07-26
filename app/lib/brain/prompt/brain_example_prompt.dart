class BrainExamplePrompt {
  const BrainExamplePrompt._();

  static String build() {
    return '''
==========================
ESEMPI
==========================


ESEMPIO 1

Messaggio:

Mi chiamo Emanuele.

Output:

{
  "version":1,

  "operation":"store",

  "memoryType":"semantic",

  "confidence":1.0,

  "importance":1.0,

  "reason":"Nuova informazione personale.",

  "question":"",

  "entities":[
    {
      "id":"user",
      "label":"Utente",
      "type":"person"
    },
    {
      "id":"emanuele",
      "label":"Emanuele",
      "type":"person"
    }
  ],

  "relations":[
    {
      "from":"user",
      "to":"emanuele",
      "type":"hasName"
    }
  ],

  "facts":[]
}



==========================

ESEMPIO 2

Memoria esistente:

Utente → hasName → Emanuele

Messaggio:

No, mi chiamo Marco.

Output:

{
  "version":1,

  "operation":"replace",

  "memoryType":"semantic",

  "confidence":1.0,

  "importance":1.0,

  "reason":"Il nome dell'utente corregge una memoria precedente.",

  "question":"",

  "entities":[
    {
      "id":"user",
      "label":"Utente",
      "type":"person"
    },
    {
      "id":"marco",
      "label":"Marco",
      "type":"person"
    }
  ],

  "relations":[
    {
      "from":"user",
      "to":"marco",
      "type":"hasName"
    }
  ],

  "facts":[]
}



==========================

ESEMPIO 3

Memoria esistente:

Utente → hasName → Emanuele

Messaggio:

Mi chiamano Lele.

Output:

{
  "version":1,

  "operation":"store",

  "memoryType":"semantic",

  "confidence":0.95,

  "importance":0.8,

  "reason":"Nuovo soprannome.",

  "question":"",

  "entities":[
    {
      "id":"lele",
      "label":"Lele",
      "type":"person"
    }
  ],

  "relations":[
    {
      "from":"user",
      "to":"lele",
      "type":"hasNickname"
    }
  ],

  "facts":[]
}



==========================

ESEMPIO 4

Messaggio:

Come mi chiamo?

Output:

{
  "version":1,

  "operation":"ignore",

  "memoryType":"semantic",

  "confidence":1.0,

  "importance":0.0,

  "reason":"Domanda dell'utente.",

  "question":"",

  "entities":[],

  "relations":[],

  "facts":[]
}



==========================

ESEMPIO 5

Esiste una possibile ambiguità.

Output:

{
  "version":1,

  "operation":"clarify",

  "memoryType":"semantic",

  "confidence":0.55,

  "importance":1.0,

  "reason":"Possibile conflitto con una memoria esistente.",

  "question":"Avevo memorizzato che ti chiami Emanuele. Vuoi sostituire questa informazione con Marco?",

  "entities":[],

  "relations":[],

  "facts":[]
}
''';
  }
}