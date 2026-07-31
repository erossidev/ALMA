import 'package:yaml/yaml.dart';

import 'ontology.dart';
import 'ontology_category.dart';
import 'ontology_entity_type.dart';
import 'ontology_fact_type.dart';
import 'ontology_relation.dart';

class OntologyMapper {
  const OntologyMapper._();

  static Ontology fromYaml(
    YamlMap yaml,
  ) {
    final version =
        yaml['version'] as int? ?? 1;

    // =====================================================
    // ENTITY TYPES
    // =====================================================

    final entityTypes = <OntologyEntityType>[];

    final entityYaml =
        yaml['entityTypes'] as YamlList? ?? YamlList();

    for (final item in entityYaml) {
      final map = item as YamlMap;

      entityTypes.add(
        OntologyEntityType(
          id: map['id'].toString(),
        ),
      );
    }

    // =====================================================
    // FACT TYPES
    // =====================================================

    final factTypes = <OntologyFactType>[];

    final factYaml =
        yaml['factTypes'] as YamlList? ?? YamlList();

    for (final item in factYaml) {
      final map = item as YamlMap;

      factTypes.add(
        OntologyFactType(
          id: map['id'].toString(),
        ),
      );
    }

    // =====================================================
    // RELATIONS
    // =====================================================

    final relations = <OntologyRelation>[];

    final categories =
        yaml['categories'] as YamlMap? ?? YamlMap();

    for (final categoryEntry in categories.entries) {
      final category =
          OntologyCategory.values.firstWhere(
        (e) => e.name == categoryEntry.key,
      );

      final items =
          categoryEntry.value as YamlList;

      for (final item in items) {
        final map = item as YamlMap;

        relations.add(
          OntologyRelation(
            id: map['id'].toString(),
            category: category,
            description: "",
            aliases: const [],
            examples: const [],
          ),
        );
      }
    }

    // =====================================================

    return Ontology(
      version: version,
      entityTypes: entityTypes,
      relations: relations,
      factTypes: factTypes,
    );
  }
}