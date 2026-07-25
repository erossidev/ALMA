import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';

class ActivationPropagator {
  final Brain brain;

  ActivationPropagator(this.brain);

  List<Neuron> propagate(
    List<String> startNeurons, {
    int maxDepth = 2,
  }) {
    final Map<String, double> activation = {};

    final List<String> frontier = [];

    // Attivazione iniziale
    for (final id in startNeurons) {
      activation[id] = 1.0;
      frontier.add(id);
    }

    int depth = 0;

    while (frontier.isNotEmpty && depth < maxDepth) {
      final current = frontier.removeAt(0);

      final currentActivation =
          activation[current] ?? 0;

      final connections =
          brain.getConnections(current);

      for (final synapse in connections) {
        final target =
            synapse.from.id == current
                ? synapse.to
                : synapse.from;

        final propagated =
            currentActivation *
            synapse.weight;

        final previous =
            activation[target.id] ?? 0;

        if (propagated > previous) {
          activation[target.id] =
              propagated;

          frontier.add(target.id);
        }
      }

      depth++;
    }

    final neurons = activation.entries
        .map((e) => brain.getNeuron(e.key))
        .whereType<Neuron>()
        .toList();

    neurons.sort((a, b) {
      return (activation[b.id] ?? 0)
          .compareTo(
        activation[a.id] ?? 0,
      );
    });

    return neurons;
  }
}