import 'semantic_cortex.dart';
import 'semantic_loader.dart';
import 'semantic_parser.dart';
import 'yaml_semantic_loader.dart';
import 'yaml_semantic_parser.dart';

class SemanticBootstrap {

  final SemanticLoader loader;

  final SemanticParser parser;

  const SemanticBootstrap({
    this.loader = const YamlSemanticLoader(),
    this.parser = const YamlSemanticParser(),
  });

  Future<void> initialize(
    SemanticCortex cortex,
  ) async {


    final text = await loader.load(
    "assets/semantic/entities.yaml",
    );

    final nodes = await parser.parse(
      text,
    );

print("===== SEMANTIC BOOTSTRAP =====");
print("Loaded ${nodes.length} entities");

    for (final node in nodes) {
      cortex.register(node);
    }

print("==============================");

  }
}