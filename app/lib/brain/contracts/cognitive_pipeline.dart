import '../protocol/brain_result.dart';

abstract class CognitivePipeline {
  const CognitivePipeline();

  Future<BrainResult> process(
    String message,
  );
}