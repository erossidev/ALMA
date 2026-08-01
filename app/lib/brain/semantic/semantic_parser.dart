import 'semantic_node.dart';

abstract class SemanticParser {
  const SemanticParser();

  Future<List<SemanticNode>> parse(
    String source,
  );
}