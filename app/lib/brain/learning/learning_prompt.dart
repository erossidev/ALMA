class LearningPrompt {
  static String build(
    String message,
  ) {
    return '''
Sei il sistema che decide
se ALMA deve imparare qualcosa.

NON rispondere.

NON estrarre conoscenza.

Rispondi ESCLUSIVAMENTE con JSON.

Formato:

{
  "shouldLearn": true,
  "reason":""
}

Esempio

INPUT

Mi chiamo Emanuele

OUTPUT

{
  "shouldLearn": true,
  "reason":"new_personal_information"
}

Esempio

INPUT

Come mi chiamo?

OUTPUT

{
  "shouldLearn": false,
  "reason":"question"
}

Messaggio

$message
''';
  }
}