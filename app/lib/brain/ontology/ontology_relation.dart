import 'ontology_category.dart';
import 'ontology_entity_type.dart';

class OntologyRelation {

  /// Identificatore univoco della relazione.
  final String id;

  /// Categoria dell'Ontology.
  final OntologyCategory category;

  /// Tipo dell'entità sorgente.
  final OntologyEntityType sourceType;

  /// Tipo dell'entità destinazione.
  final OntologyEntityType targetType;

  /// Descrizione della relazione.
  final String description;

  /// Sinonimi utilizzabili dal Language Translator.
  final List<String> aliases;

  /// Frasi di esempio.
  final List<String> examples;

  /// Relazione inversa.
  final String? inverse;

  /// Indica se una relazione può esistere una sola volta.
  final bool exclusive;

  /// Indica se la relazione può cambiare nel tempo.
  final bool mutable;

  const OntologyRelation({

  required this.id,

  required this.category,

  required this.sourceType,

  required this.targetType,

  required this.description,

  this.aliases = const [],

  this.examples = const [],

  this.inverse,

  this.exclusive = false,

  this.mutable = true,

});

}