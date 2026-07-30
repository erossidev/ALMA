// lib/brain/nervous_system/nervous_system.dart

import '../executive/execution_context.dart';
import '../executive/executive_cortex.dart';

class NervousSystem {
  final ExecutiveCortex executive;

  const NervousSystem({
    required this.executive,
  });

  Future<void> process(
    ExecutionContext context,
  ) async {
    await executive.execute(
      context,
    );
  }
}