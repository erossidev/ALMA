import 'ontology_loader.dart';
import 'ontology.dart';
import 'ontology_entity_type.dart';
import 'ontology_fact_type.dart';
import 'ontology_relation.dart';

class OntologyPromptBuilder {
  const OntologyPromptBuilder._();

  static Future<String> build() async {

    final Ontology ontology =
        await OntologyLoader.load();

    final buffer = StringBuffer();

    buffer.writeln("ONTOLOGIA ATTUALE DI ALMA");
    buffer.writeln();

    buffer.writeln("ENTITY TYPES:");

    for (final OntologyEntityType type
        in ontology.entityTypes) {
      buffer.writeln("- ${type.id}");
    }

    buffer.writeln();

    buffer.writeln("FACT TYPES:");

    for (final OntologyFactType type
        in ontology.factTypes) {
      buffer.writeln("- ${type.id}");
    }

    buffer.writeln();

    buffer.writeln("RELATIONS:");

    for (final OntologyRelation relation
        in ontology.relations) {
      buffer.writeln("- ${relation.id}");
    }

    return buffer.toString();
  }
}