import 'meaning_entity.dart';
import 'meaning_proposition.dart';

class Meaning {

  final String version;

  final List<MeaningEntity> entities;

  final List<MeaningProposition> propositions;

  const Meaning({

    required this.version,

    required this.entities,

    required this.propositions,

  });

}