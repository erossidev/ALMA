import '../synapse.dart';
import '../retrieval/memory_result.dart';
import '../brain_vocabulary.dart';

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
          case RelationshipType.hasName:
            if (synapse.from.id == "user") {
              buffer.writeln(
                "- L'utente si chiama ${synapse.to.label}.",
              );
            }
            break;

          case RelationshipType.birthDate:
            if (synapse.from.id == "user") {
              buffer.writeln(
                "- L'utente è nato il ${synapse.to.label}.",
              );
            } else {
              buffer.writeln(
                "- ${synapse.from.label} è nato il ${synapse.to.label}.",
              );
            }
            break;

          case RelationshipType.birthPlace:
            if (synapse.from.id == "user") {
              buffer.writeln(
                "- L'utente è nato a ${synapse.to.label}.",
              );
            } else {
              buffer.writeln(
                "- ${synapse.from.label} è nato a ${synapse.to.label}.",
              );
            }
            break;

          case RelationshipType.livesIn:
            buffer.writeln(
              "- ${synapse.from.label} vive a ${synapse.to.label}.",
            );
            break;

          case RelationshipType.spouse:
            buffer.writeln(
              "- ${synapse.from.label} è sposato con ${synapse.to.label}.",
            );
            break;

          case RelationshipType.likes:
            buffer.writeln(
              "- ${synapse.from.label} ama ${synapse.to.label}.",
            );
            break;

          case RelationshipType.dislikes:
            buffer.writeln(
              "- ${synapse.from.label} non ama ${synapse.to.label}.",
            );
            break;

          case RelationshipType.loves:
            buffer.writeln(
              "- ${synapse.from.label} adora ${synapse.to.label}.",
            );
            break;

          case RelationshipType.hates:
            buffer.writeln(
              "- ${synapse.from.label} odia ${synapse.to.label}.",
            );
            break;

          case RelationshipType.worksAt:
            buffer.writeln(
              "- ${synapse.from.label} lavora presso ${synapse.to.label}.",
            );
            break;

          case RelationshipType.studiedAt:
            buffer.writeln(
              "- ${synapse.from.label} ha studiato presso ${synapse.to.label}.",
            );
            break;

          case RelationshipType.owns:
            buffer.writeln(
              "- ${synapse.from.label} possiede ${synapse.to.label}.",
            );
            break;

          case RelationshipType.hasPet:
            buffer.writeln(
              "- ${synapse.from.label} ha come animale ${synapse.to.label}.",
            );
            break;

          case RelationshipType.uses:
            buffer.writeln(
              "- ${synapse.from.label} usa ${synapse.to.label}.",
            );
            break;

          case RelationshipType.createdBy:
            buffer.writeln(
              "- ${synapse.from.label} è stato creato da ${synapse.to.label}.",
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