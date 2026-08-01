import 'semantic_metadata.dart';
import 'semantic_node_type.dart';

class SemanticNode {
  final String id;

  final SemanticNodeType type;

  final String label;

  final SemanticMetadata metadata;

  SemanticNode({
    required this.id,
    required this.type,
    required this.label,
    SemanticMetadata? metadata,
  }) : metadata =
            metadata ??
            SemanticMetadata();

  @override
  String toString() =>
      "$label (${type.name})";
}