import '../brain_vocabulary.dart';

class ExtractedRelation {
  final String from;

  final String to;

  final RelationshipType relationship;

  const ExtractedRelation({
    required this.from,
    required this.to,
    required this.relationship,
  });
}