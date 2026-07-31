import '../brain_vocabulary.dart';
import '../conflict/brain_conflict.dart';
import '../protocol/brain_instruction.dart';

class ClarificationResolver {
  const ClarificationResolver();

  BrainInstruction resolve({
    required BrainConflict? conflict,
    required String answer,
  }) {
    // =====================================================
    // Chiarimento Ontologia
    // =====================================================

    if (conflict == null) {
      return const BrainInstruction(
        operation: BrainOperation.ignore,
      );
    }

    // =====================================================
    // Chiarimento Conflitto Memoria
    // =====================================================

    final normalized =
        answer.trim().toLowerCase();

    final chooseNew =
        normalized ==
        conflict.newLabel.toLowerCase();

    if (!chooseNew) {
      return const BrainInstruction(
        operation: BrainOperation.ignore,
      );
    }

    return BrainInstruction(
      operation: BrainOperation.replace,
      entities: [
        BrainEntity(
          id: conflict.fromId,
          label: "Utente",
          type: EntityType.person,
        ),
        BrainEntity(
          id: conflict.toId,
          label: conflict.newLabel,
          type: EntityType.person,
        ),
      ],
      relations: [
        BrainRelation(
          from: conflict.fromId,
          to: conflict.toId,
          type: conflict.relationship,
        ),
      ],
    );
  }
}