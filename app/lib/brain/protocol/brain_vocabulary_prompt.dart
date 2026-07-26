import '../brain_vocabulary.dart';


class BrainVocabularyPrompt {
  const BrainVocabularyPrompt._();


  static String build() {

    final entityTypes =
        EntityType.values
            .map((e) => e.name)
            .join(", ");


    final relations =
        RelationshipType.values
            .map((e) => e.name)
            .join(", ");


    final facts =
        FactType.values
            .map((e) => e.name)
            .join(", ");


    return '''

VOCABOLARIO DEL BRAIN DI ALMA

EntityType disponibili:

$entityTypes


RelationshipType disponibili:

$relations


FactType disponibili:

$facts


Usa esclusivamente questi valori.

Non creare nuovi tipi.

''';
  }
}