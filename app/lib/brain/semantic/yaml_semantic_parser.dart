import 'package:yaml/yaml.dart';
import 'semantic_metadata.dart';
import 'semantic_node.dart';
import 'semantic_node_type.dart';
import 'semantic_parser.dart';

class YamlSemanticParser
    implements SemanticParser {

  const YamlSemanticParser();

  @override
  Future<List<SemanticNode>> parse(
    String source,
  ) async {

    final yaml = loadYaml(source);

   final entities = yaml["entities"];

   final nodes = <SemanticNode>[];

   for (final entity in entities) {
    final id = entity["id"] as String;

    final label = entity["label"] as String;

    final node = SemanticNode(
      id: id,
      type: SemanticNodeType.entity,
      label: label,
      metadata: SemanticMetadata(
        semanticType:
            entity["semanticType"]?.toString(),

        brainType:
            entity["brainType"]?.toString(),

        description:
            entity["description"]?.toString(),

        source:
            "yaml",
      ),
);

    nodes.add(node);

}

    return nodes;
  }
}