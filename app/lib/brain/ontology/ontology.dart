import 'ontology_relation.dart';

class Ontology {
  /// Versione dell'ontologia.
  final int version;

  /// Tutte le relazioni conosciute.
  final List<OntologyRelation> relations;

  const Ontology({
    required this.version,
    required this.relations,
  });

  /// Restituisce una relazione tramite ID.
  OntologyRelation? findById(String id) {
    try {
      return relations.firstWhere(
        (relation) => relation.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  /// Verifica se una relazione esiste.
  bool contains(String id) {
    return findById(id) != null;
  }
}