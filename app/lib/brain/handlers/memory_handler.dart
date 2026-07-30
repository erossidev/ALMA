import '../executive/execution_context.dart';
import '../attention/attention_engine.dart';
import '../hippocampus/hippocampus.dart';
import '../working_memory.dart';

import 'task_handler.dart';

class MemoryHandler implements TaskHandler {

  final AttentionEngine attentionEngine;
  final Hippocampus hippocampus;
  final WorkingMemory workingMemory;

  const MemoryHandler({
    required this.attentionEngine,
    required this.hippocampus,
    required this.workingMemory,
  });

  @override
  Future<void> execute(
    ExecutionContext context,
  ) async {

    print(">>> MemoryHandler EXECUTED");

    attentionEngine.update(
      workingMemory,
    );

    hippocampus.consolidate(
      workingMemory,
    );
  }
}