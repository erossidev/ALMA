import 'semantic_node.dart';

class SemanticRelation {
  final String id;

  final SemanticNode from;

  final SemanticNode to;

  final String relationship;

  SemanticRelation({
    required this.id,
    required this.from,
    required this.to,
    required this.relationship,
  });
}