import 'package:app/core/cognition/thought.dart';
import '../../core/dialogue/models/conversation_model.dart';
import '../nervous_system/perception/perception_result.dart';
import 'cognitive_plan.dart';
import '../../brain/protocol/brain_result.dart';
import '../../core/ai/ai_response.dart';
import '../../brain/synapse.dart';

class ExecutionContext {
  final Thought thought;

  final String input;

  PerceptionResult? perception;

  ConversationModel conversation;

  CognitivePlan? plan;

  AIResponse? response;

  BrainResult? brainResult;

  bool shouldLearn = false;

  // =====================================================
  // MEMORIE RECUPERATE DAL BRAIN
  // =====================================================

  final List<Synapse> retrievedMemories = [];

  ExecutionContext({
    required this.thought,
    required this.conversation,
    required this.input,
    this.perception,
    this.plan,
    this.response,
  });
}