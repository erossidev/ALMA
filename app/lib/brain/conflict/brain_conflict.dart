import '../brain_vocabulary.dart';
import '../synapse.dart';

class BrainConflict {
  final Synapse existing;

  final String fromId;

  final String toId;

  // <-- nuovo
  final String newLabel;

  final RelationshipType relationship;

  const BrainConflict({
    required this.existing,
    required this.fromId,
    required this.toId,
    required this.newLabel,
    required this.relationship,
  });
}