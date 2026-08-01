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
}