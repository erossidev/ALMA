import 'ai_execution.dart';

abstract class AIExecutionRepository {
  Future<void> save(
    AIExecution execution,
  );

  Future<List<AIExecution>> loadAll();

  Future<void> clear();
}