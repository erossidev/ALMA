import 'ontology_category.dart';

class OntologyRelation {
  final String id;

  final OntologyCategory category;

  final String description;

  final List<String> aliases;

  final List<String> examples;

  const OntologyRelation({
    required this.id,
    required this.category,
    this.description = "",
    this.aliases = const [],
    this.examples = const [],
  });
}