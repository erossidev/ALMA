class BrainOperationPrompt {
  const BrainOperationPrompt._();

  static String build() {
    return '''
==========================
OPERAZIONI
==========================

Usa esclusivamente una delle seguenti operazioni.

store

Crea una nuova memoria.

Usalo quando il messaggio contiene
una nuova informazione che non è
presente nel Brain.



replace

Sostituisce una memoria esistente.

Usalo quando sei certo che una nuova
informazione corregga una memoria
precedente.



merge

Unisce due memorie compatibili.

Usalo quando il nuovo messaggio
arricchisce una memoria già esistente
senza contraddirla.



delete

Elimina una memoria.

Usalo quando il messaggio indica che
una memoria non è più valida.



reinforce

Rafforza una memoria esistente.

Usalo quando il messaggio conferma
una memoria già presente nel Brain.



ignore

Non modificare il Brain.

Usalo quando il messaggio non contiene
nuova conoscenza.



clarify

Esiste una possibile ambiguità
o un possibile conflitto.

NON modificare il Brain.

Compila il campo:

question

contenente la domanda che ALMA
dovrà porre all'utente.

Se non sei sufficientemente sicuro
della decisione da prendere,
preferisci clarify a replace.
''';
  }
}