class BrainMemoryPrompt {
  const BrainMemoryPrompt._();

  static String build() {
    return '''
==========================
MEMORY TYPE
==========================

Scegli esclusivamente uno dei seguenti
tipi di memoria.

semantic

Conoscenza stabile.

Esempi:

- nome
- professione
- preferenze
- relazioni



episodic

Evento specifico avvenuto nel tempo.



working

Informazione temporanea utile
al ragionamento corrente.



temporary

Informazione ancora non consolidata.



derived

Informazione dedotta da altre
conoscenze.

Non inventare deduzioni.

Usa derived solo quando la deduzione
è logicamente certa.
''';
  }
}