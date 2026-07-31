import 'knowledge_entity.dart';
import 'knowledge_relation.dart';
import 'knowledge_fact.dart';

/// ==========================================================
/// KNOWLEDGE MODEL
///
/// Contiene ESATTAMENTE quello che estrae l'LLM.
///
/// Nessuna decisione.
/// Nessuna logica.
/// Nessun tipo del Brain.
///
/// È il livello intermedio tra AI e Brain.
/// ==========================================================

class KnowledgeModel {
  final List<KnowledgeEntity> entities;

  final List<KnowledgeRelation> relations;

  final List<KnowledgeFact> facts;

  const KnowledgeModel({
    this.entities = const [],
    this.relations = const [],
    this.facts = const [],
  });

  bool get isEmpty =>
      entities.isEmpty &&
      relations.isEmpty &&
      facts.isEmpty;

  bool get isNotEmpty => !isEmpty;
}