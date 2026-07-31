import '../executive/execution_context.dart';
import '../attention/attention_engine.dart';
import '../hippocampus/hippocampus.dart';
import '../working_memory.dart';
import '../retrieval/brain_retriever.dart';

import 'task_handler.dart';

class MemoryHandler implements TaskHandler {

  final AttentionEngine attentionEngine;

  final Hippocampus hippocampus;

  final WorkingMemory workingMemory;

  final BrainRetriever brainRetriever;

  const MemoryHandler({
    required this.attentionEngine,
    required this.hippocampus,
    required this.workingMemory,
    required this.brainRetriever,
  });

  @override
  Future<void> execute(
    ExecutionContext context,
  ) async {

    print(">>> MemoryHandler EXECUTED");

    // =====================================================
    // RECUPERO MEMORIE DAL BRAIN
    // =====================================================

    final memories = brainRetriever.retrieve(
      context.input,
    );

    context.retrievedMemories.clear();

    context.retrievedMemories.addAll(
      memories,
    );

    print(
      ">>> Recuperate ${memories.length} memorie",
    );

    // =====================================================
    // ATTENZIONE
    // =====================================================

    attentionEngine.update(
      workingMemory,
    );

    // =====================================================
    // CONSOLIDAMENTO
    // =====================================================

    hippocampus.consolidate(
      workingMemory,
    );
  }
}