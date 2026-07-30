import '../executive/execution_context.dart';

abstract class TaskHandler {
  Future<void> execute(
    ExecutionContext context,
  );
}