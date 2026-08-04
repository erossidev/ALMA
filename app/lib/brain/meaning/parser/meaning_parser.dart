import 'dart:convert';

import '../meaning.dart';
import '../atoms/meaning_entity.dart';
import '../atoms/meaning_proposition.dart';
import 'meaning_parser_exception.dart';

class MeaningParser {
  const MeaningParser();

  Meaning parse(String json) {
    final Map<String, dynamic> root = jsonDecode(json);

    final version = root['version'];

    if (version == null) {
      throw const MeaningParserException(
        'Missing protocol version.',
      );
    }

    final entities = _buildEntities(root);

    final propositions = _buildPropositions(root);

    _validate(
      entities,
      propositions,
    );

    return Meaning(
      version: version,
      entities: entities,
      propositions: propositions,
    );
  }

  List<MeaningEntity> _buildEntities(
    Map<String, dynamic> root,
  ) {
    final entitiesJson = root['entities'];

    if (entitiesJson == null) {
      throw const MeaningParserException(
        'Missing entities list.',
      );
    }

    if (entitiesJson is! List) {
      throw const MeaningParserException(
        'Entities must be a list.',
      );
    }

    final entities = <MeaningEntity>[];

    for (final item in entitiesJson) {
      entities.add(
        MeaningEntity(
          id: item['id'],
          text: item['text'],
        ),
      );
    }

    return entities;
  }

  List<MeaningProposition> _buildPropositions(
    Map<String, dynamic> root,
  ) {
    final propositionsJson = root['propositions'];

    if (propositionsJson == null) {
      throw const MeaningParserException(
        'Missing propositions list.',
      );
    }

    if (propositionsJson is! List) {
      throw const MeaningParserException(
        'Propositions must be a list.',
      );
    }

    final propositions = <MeaningProposition>[];

    for (final item in propositionsJson) {
      propositions.add(
        MeaningProposition(
          subject: item['subject'],
          predicate: item['predicate'],
          object: item['object'],
        ),
      );
    }

    return propositions;
  }

  void _validate(
    List<MeaningEntity> entities,
    List<MeaningProposition> propositions,
  ) {
    // Per ora lasciamo il metodo vuoto.
    // Nel prossimo commit aggiungeremo:
    // - Entity duplicate
    // - Subject inesistenti
    // - Object referenziati inesistenti
    // - Versione supportata
  }
}