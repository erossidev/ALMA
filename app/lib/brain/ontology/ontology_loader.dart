import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart' as yaml;

import 'ontology.dart';
import 'ontology_mapper.dart';

class OntologyLoader {
  const OntologyLoader._();

  static Future<Ontology> load() async {
    final text = await rootBundle.loadString(
      'assets/ontology/ontology.yaml',
    );

    final map =
        yaml.loadYaml(text)
            as yaml.YamlMap;

    return OntologyMapper.fromYaml(
      map,
    );
  }
}