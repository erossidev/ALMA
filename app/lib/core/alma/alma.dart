import '../../brain/brain.dart';
import '../../brain/cognitive_engine.dart';
import '../../brain/working_memory.dart';

import '../../brain/attention/attention_engine.dart';
import '../../brain/hippocampus/hippocampus.dart';

import '../ai/ai_manager.dart';

import '../../brain/repositories/firebase_brain_repository.dart';

class Alma {
  Alma._internal();

  static final Alma instance = Alma._internal();

  // ==========================
  // CERVELLO
  // ==========================

  final Brain brain = Brain();

  final WorkingMemory workingMemory = WorkingMemory();

  final AttentionEngine attentionEngine = AttentionEngine();

  final Hippocampus hippocampus = Hippocampus();

  final AIManager aiManager = AIManager();

  final FirebaseBrainRepository repository =
    FirebaseBrainRepository();

  Future<void> initialize() async {
  final loadedBrain = await repository.loadBrain();;

  brain.copyFrom(loadedBrain);
  }

  late final CognitiveEngine cognitiveEngine =
      CognitiveEngine(
    brain: brain,
    workingMemory: workingMemory,
    attentionEngine: attentionEngine,
    hippocampus: hippocampus,
    aiManager: aiManager,
  );
}