import 'package:flutter/services.dart';

import 'semantic_loader.dart';

class YamlSemanticLoader
    implements SemanticLoader {

  const YamlSemanticLoader();

  @override
  Future<String> load(
    String source,
  ) {
    return rootBundle.loadString(
      source,
    );
  }
}