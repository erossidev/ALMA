import 'package:yaml/yaml.dart';

import 'ontology.dart';
import 'ontology_relation.dart';
import 'ontology_category.dart';
import 'ontology_entity_type.dart';

class OntologyMapper {
  const OntologyMapper._();

  static Ontology fromYaml(
    YamlMap yaml,
  ) {
    final version =
        yaml['version'] as int? ?? 1;

    final relations =
        <OntologyRelation>[];

    final categories =
        yaml['categories'] as YamlMap;

    for (final categoryEntry
        in categories.entries) {
      final category =
          OntologyCategory.values.firstWhere(
        (e) =>
            e.name ==
            categoryEntry.key,
      );

      final items =
          categoryEntry.value as YamlList;

      for (final item in items) {
        final map =
            item as YamlMap;

        relations.add(
          OntologyRelation(
            id: map['id'],
            category: category,

            sourceType:
                OntologyEntityType.unknown,

            targetType:
                OntologyEntityType.unknown,

            description: "",

            aliases: const [],

            examples: const [],
          ),
        );
      }
    }

    return Ontology(
      version: version,
      relations: relations,
    );
  }
}