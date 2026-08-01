import 'instruction_status.dart';

class InstructionResult<T> {
  final InstructionStatus status;
  final T? value;
  final String? message;

  const InstructionResult({
    required this.status,
    this.value,
    this.message,
  });

  bool get success =>
      status == InstructionStatus.success;

  factory InstructionResult.success([
    T? value,
  ]) {
    return InstructionResult(
      status: InstructionStatus.success,
      value: value,
    );
  }

  factory InstructionResult.failed(
    String message,
  ) {
    return InstructionResult(
      status: InstructionStatus.failed,
      message: message,
    );
  }

  factory InstructionResult.notFound() {
    return InstructionResult(
      status: InstructionStatus.notFound,
    );
  }

  factory InstructionResult.alreadyExists() {
    return InstructionResult(
      status: InstructionStatus.alreadyExists,
    );
  }
}