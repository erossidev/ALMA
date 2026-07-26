import '../conflict/brain_conflict.dart';
import 'brain_instruction.dart';

class BrainResult {
  final BrainOperation operation;

  final bool success;

  final bool requiresClarification;

  final String? question;

  final String? reason;

  final BrainConflict? conflict;

  const BrainResult({
    required this.operation,
    required this.success,
    this.requiresClarification = false,
    this.question,
    this.reason,
    this.conflict,
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
    required String question,
    String? reason,
    BrainConflict? conflict,
  }) {
    return BrainResult(
      operation: BrainOperation.clarify,
      success: false,
      requiresClarification: true,
      question: question,
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