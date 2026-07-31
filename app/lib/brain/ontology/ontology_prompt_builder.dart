import 'ontology.dart';
import 'ontology_relation.dart';

class OntologyPromptBuilder {
  const OntologyPromptBuilder._();

  static String build(Ontology ontology) {
    final buffer = StringBuffer();

    buffer.writeln("VOCABOLARIO DEL BRAIN DI ALMA");
    buffer.writeln();

    buffer.writeln("RelationshipType disponibili:");
    buffer.writeln();

    for (final OntologyRelation relation in ontology.relations) {
      buffer.writeln("- ${relation.id}");
    }

    buffer.writeln();

    return buffer.toString();
  }
}