import 'brain_instruction.dart';

class BrainInstructionParser {
  const BrainInstructionParser();

  BrainInstruction parse(
    Map<String, dynamic> json,
  ) {
    return BrainInstruction(
      version: json["version"] ?? 1,

      operation: _parseOperation(
        json["operation"],
      ),

      memoryType: _parseMemoryType(
        json["memoryType"],
      ),

      confidence:
          (json["confidence"] ?? 1.0).toDouble(),

      importance:
          (json["importance"] ?? 1.0).toDouble(),

      replaceExisting:
          json["replaceExisting"] ?? false,

      reason:
          json["reason"] ?? "",

      entities:
          List<Map<String, dynamic>>.from(
        json["entities"] ?? [],
      ),

      relations:
          List<Map<String, dynamic>>.from(
        json["relations"] ?? [],
      ),

      facts:
          List<Map<String, dynamic>>.from(
        json["facts"] ?? [],
      ),
    );
  }

  BrainOperation _parseOperation(
    String? value,
  ) {
    switch (value) {
      case "store":
        return BrainOperation.store;

      case "replace":
        return BrainOperation.replace;

      case "merge":
        return BrainOperation.merge;

      case "delete":
        return BrainOperation.delete;

      case "reinforce":
        return BrainOperation.reinforce;

      case "ignore":
      default:
        return BrainOperation.ignore;
    }
  }

  MemoryType _parseMemoryType(
    String? value,
  ) {
    switch (value) {
      case "semantic":
        return MemoryType.semantic;

      case "episodic":
        return MemoryType.episodic;

      case "working":
        return MemoryType.working;

      case "temporary":
        return MemoryType.temporary;

      case "derived":
        return MemoryType.derived;

      default:
        return MemoryType.semantic;
    }
  }
}