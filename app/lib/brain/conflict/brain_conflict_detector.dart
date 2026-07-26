import '../brain.dart';
import '../brain_vocabulary.dart';
import '../synapse.dart';
import 'brain_conflict.dart';

class BrainConflictDetector {
  const BrainConflictDetector();
    BrainConflict? detect({
      required Brain brain,
      required String fromId,
      required RelationshipType relationship,
      required String toId,
    }) {
      if (!BrainVocabulary.isSingleRelation(
        relationship,
      )) {
        return null;
      }

      for (final synapse in brain.synapses) {
        if (synapse.from.id != fromId) {
          continue;
        }

        if (synapse.relationship != relationship) {
          continue;
        }

        if (synapse.to.id == toId) {
          return null;
        }

        return BrainConflict(
          existing: synapse,
          fromId: fromId,
          toId: toId,
          relationship: relationship,
        );
      }

  return null;
}
}