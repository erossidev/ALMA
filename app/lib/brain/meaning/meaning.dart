import 'atoms/meaning_entity.dart';
import 'atoms/meaning_proposition.dart';

class Meaning {

  final int version;

  final List<MeaningEntity> entities;

  final List<MeaningProposition> propositions;

  const Meaning({
    required this.version,
    required this.entities,
    required this.propositions,
  });

}