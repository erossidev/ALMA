import '../conflict/brain_conflict.dart';
import 'brain_instruction.dart';
import '../semantic/learning/semantic_proposal.dart';

class BrainResult {
  final BrainOperation operation;

  final bool success;

  final bool requiresClarification;

  final String? question;

  final String? reason;

  final BrainConflict? conflict;

  final SemanticProposal? proposal;

  const BrainResult({
    required this.operation,
    required this.success,
    this.requiresClarification = false,
    this.question,
    this.reason,
    this.conflict,
      this.proposal,
  });

  factory BrainResult.success(
    BrainOperation operation,
  ) {
    return BrainResult(
      operation: operation,
      success: true,
    );
  }

  factory BrainResult.ignored() {
    return BrainResult(
      operation: BrainOperation.ignore,
      success: true,
    );
  }

 factory BrainResult.clarification({
  String? question,
  SemanticProposal? proposal,
  String? reason,
  BrainConflict? conflict,
}) {
  return BrainResult(
    operation: BrainOperation.clarify,
    success: false,
    requiresClarification: true,
    question: question,
    proposal: proposal,
    reason: reason,
    conflict: conflict,
  );
}


  factory BrainResult.failure(
    BrainOperation operation,
    String reason,
  ) {
    return BrainResult(
      operation: operation,
      success: false,
      reason: reason,
    );
  }
}