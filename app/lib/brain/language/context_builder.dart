import '../brain.dart';
import '../neuron.dart';

class ContextBuilder {
  final Brain brain;

  ContextBuilder(this.brain);

  String build(String userMessage) {
    final buffer = StringBuffer();

    // Recupera tutti i neuroni attivi
    final activeNeurons = brain.neurons.where(
      (n) => n.state.activation > 0,
    );

    if (activeNeurons.isNotEmpty) {
      buffer.writeln(
        "Conoscenze già acquisite:"
      );

      for (final neuron in activeNeurons) {
        buffer.writeln(
          "- ${neuron.label}"
        );
      }

      buffer.writeln();
    }

    buffer.writeln(userMessage);

    return buffer.toString();
  }
}