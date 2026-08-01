import '../brain.dart';
import '../brain_vocabulary.dart';
import '../neuron.dart';
import '../synapse.dart';

import '../protocol/brain_instruction.dart';
import '../protocol/brain_result.dart';

import '../repositories/brain_repository.dart';

import '../conflict/brain_conflict.dart';
import '../conflict/brain_conflict_detector.dart';

import '../reasoning/brain_clarifier.dart';

import '../compiler/execution_compiler.dart';
import '../executor/brain_instruction_executor.dart';
import '../context/brain_context.dart';

class BrainMemoryManager {
  final Brain brain;

  final BrainRepository repository;

  final ExecutionCompiler _compiler =
    const ExecutionCompiler();

  final BrainInstructionExecutor _executor =
      const BrainInstructionExecutor();

  final BrainConflictDetector
      _conflictDetector =
          const BrainConflictDetector();

  final BrainClarifier
    _clarifier =
        const BrainClarifier();

  BrainMemoryManager({
    required this.brain,
    required this.repository,
  });

  // =====================================================
  // STORE
  // =====================================================

Future<BrainResult> store(
  BrainInstruction instruction,
) async {
  print(">>> BrainMemoryManager.store()");
  print(">>> PRIMA DI EXECUTION PLAN");

  final conflict = await _detectConflict(
    instruction,
  );

  if (conflict != null) {
    print(
      ">>> CONFLITTO RILEVATO",
    );

    final question =
        await _clarifier.generate(
      conflict,
    );

    return BrainResult.clarification(
      question: question,
      reason: "Single relation conflict",
      conflict: conflict,
    );
  }

  final plan = _compiler.compileStore(
    instruction,
  );

  final context = BrainContext(
    brain: brain,
    repository: repository,
  );

  await _executor.execute(
    plan,
    context,
  );

  print(
    ">>> DOPO EXECUTION PLAN",
  );

  _debugBrain();

  print(brain);

  return _success(
    BrainOperation.store,
  );
}

  // =====================================================
  // REPLACE
  // =====================================================

  Future<BrainResult> replace(
  BrainInstruction instruction,
) async {
  print(">>> BrainMemoryManager.replace()");
  print(">>> PRIMA DI EXECUTION PLAN");

  final plan = _compiler.compileReplace(
    instruction,
  );

  final context = BrainContext(
    brain: brain,
    repository: repository,
  );

  await _executor.execute(
    plan,
    context,
  );

  print(
    ">>> DOPO EXECUTION PLAN",
  );

  _debugBrain();

  print(brain);

  return _success(
    BrainOperation.replace,
  );
}

  // =====================================================
  // MERGE
  // =====================================================

  Future<BrainResult> merge(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.merge()");

    // TODO

    _debugBrain();

    return _success(
      BrainOperation.merge,
    );
  }

  // =====================================================
  // DELETE
  // =====================================================

  Future<BrainResult> delete(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.delete()");

    // TODO

    _debugBrain();

    return _success(
      BrainOperation.delete,
    );
  }

  // =====================================================
  // REINFORCE
  // =====================================================

  Future<BrainResult> reinforce(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.reinforce()");

    // TODO

    _debugBrain();

    return _success(
      BrainOperation.reinforce,
    );
  }

  // =====================================================
  // CLARIFY
  // =====================================================

  Future<BrainResult> clarify(
    BrainInstruction instruction,
  ) async {
    print(">>> BrainMemoryManager.clarify()");

    return BrainResult.clarification(
      question:
          instruction.question ?? "",
      reason:
          instruction.reason,
    );
  }

// =====================================================
// RILEVAMENTO CONFLITTI
// =====================================================

  Future<BrainConflict?> _detectConflict(
  BrainInstruction instruction,
) async {
  for (final relation in instruction.relations) {
    final conflict =
        _conflictDetector.detect(
      brain: brain,
      fromId: relation.from,
      relationship: relation.type,
      toId: relation.to,
    );

  if (conflict != null) {
    final to = brain.getNeuron(
        relation.to,
      );

    return BrainConflict(
      existing: conflict.existing,
      fromId: conflict.fromId,
      toId: conflict.toId,
      newLabel: to?.label ?? relation.to,
      relationship: conflict.relationship,
    );
}
  }

  return null;
}

  
  // =====================================================
  // SUCCESS
  // =====================================================

  BrainResult _success(
    BrainOperation operation,
  ) {
    return BrainResult.success(
      operation,
    );
  }

  // =====================================================
  // DEBUG
  // =====================================================

  void _debugBrain() {
    print("");

    print("===== NEURONI =====");

    for (final neuron
        in brain.neurons) {
      print(
        "${neuron.id} (${neuron.type.name})",
      );
    }

    print("");

    print("===== SINAPSI =====");

    for (final synapse
        in brain.synapses) {
      print(
        "${synapse.id}"
        " -> ${synapse.relationship.name}"
        " (${synapse.from.label} -> ${synapse.to.label})",
      );
    }

    print("===================");
    print("");
  }
}