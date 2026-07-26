import '../retrieval/memory_result.dart';
import '../brain_vocabulary.dart';

class BrainMemoryContextBuilder {
  const BrainMemoryContextBuilder();

  String build(
    MemoryResult memory,
  ) {
    if (memory.relations.isEmpty) {
      return "Nessuna memoria presente.";
    }

    final buffer = StringBuffer();

    buffer.writeln(
      "Conoscenze già presenti nel Brain:\n",
    );

    for (final relation in memory.relations) {
      switch (relation.relationship) {
        case RelationshipType.hasName:
          buffer.writeln(
            "- L'utente si chiama ${relation.to.label}.",
          );
          break;

        case RelationshipType.hasNickname:
          buffer.writeln(
            "- L'utente ha il soprannome ${relation.to.label}.",
          );
          break;

        case RelationshipType.spouse:
          buffer.writeln(
            "- L'utente è sposato con ${relation.to.label}.",
          );
          break;

        case RelationshipType.hasFather:
          buffer.writeln(
            "- Il padre dell'utente è ${relation.to.label}.",
          );
          break;

        case RelationshipType.hasMother:
          buffer.writeln(
            "- La madre dell'utente è ${relation.to.label}.",
          );
          break;

        case RelationshipType.hasBrother:
          buffer.writeln(
            "- Il fratello dell'utente è ${relation.to.label}.",
          );
          break;

        case RelationshipType.hasSister:
          buffer.writeln(
            "- La sorella dell'utente è ${relation.to.label}.",
          );
          break;

        default:
          buffer.writeln(
            "- ${relation.from.label} → ${relation.relationship.name} → ${relation.to.label}",
          );
      }
    }

    return buffer.toString();
  }
}