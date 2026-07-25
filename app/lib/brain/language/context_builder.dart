import '../synapse.dart';
import '../retrieval/memory_result.dart';

class ContextBuilder {
  String build(
    String userMessage,
    MemoryResult memory,
  ) {
    final buffer = StringBuffer();

    if (memory.isNotEmpty) {
      buffer.writeln("Conoscenze di ALMA:");
      buffer.writeln();

      for (final synapse in memory.synapses) {
        switch (synapse.relationship) {
          case RelationshipType.knows:
            if (synapse.from.id == "user") {
              buffer.writeln(
                "- L'utente si chiama ${synapse.to.label}.",
              );
            }
            break;

          case RelationshipType.likes:
            buffer.writeln(
              "- ${synapse.from.label} ama ${synapse.to.label}.",
            );
            break;

          case RelationshipType.uses:
            buffer.writeln(
              "- ${synapse.from.label} usa ${synapse.to.label}.",
            );
            break;

          default:
            buffer.writeln(
              "- ${synapse.from.label} → ${synapse.relationship.name} → ${synapse.to.label}",
            );
        }
      }

      buffer.writeln();
    }

    buffer.writeln("Domanda:");
    buffer.writeln(userMessage);

    return buffer.toString();
  }
}