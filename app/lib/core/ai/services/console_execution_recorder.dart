import 'ai_execution_recorder.dart';

import '../ai_request.dart';
import '../ai_response.dart';

class ConsoleExecutionRecorder
    implements AIExecutionRecorder {

  const ConsoleExecutionRecorder();

  @override
  Future<void> record({
    required AIRequest request,
    required AIResponse response,
  }) async {

    print("");
    print("=========== AI EXECUTION ===========");

    print("Task        : ${request.task.name}");

    print("Provider    : ${response.provider}");

    print("Model       : ${response.model}");

    print("Prompt      : ${response.usage.promptTokens}");

    print("Completion  : ${response.usage.completionTokens}");

    print("Total       : ${response.usage.totalTokens}");

    print("Time        : ${response.usage.responseTimeMs} ms");

    print("===================================");

    print("");
  }
}