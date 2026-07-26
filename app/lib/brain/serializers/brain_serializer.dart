import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';
import '../brain_vocabulary.dart';

class BrainSerializer {
  /// ==========================
  /// SERIALIZZAZIONE
  /// ==========================

  static Map<String, dynamic> toJson(
    Brain brain,
  ) {
    return {
      'neurons': brain.neurons
          .map((n) => n.toJson())
          .toList(),

      'synapses': brain.synapses
          .map((s) => s.toJson())
          .toList(),
    };
  }

  /// ==========================
  /// DESERIALIZZAZIONE
  /// ==========================

  static Brain fromJson(
    Map<String, dynamic> json,
  ) {
    final brain = Brain();

    // --------------------------
    // 1. Carica neuroni
    // --------------------------

    final neurons =
        (json['neurons'] as List?) ?? [];

    for (final item in neurons) {
      final neuron =
          Neuron.fromJson(
        Map<String, dynamic>.from(item),
      );

      brain.addNeuron(neuron);
    }

    // --------------------------
    // 2. Carica sinapsi
    // --------------------------

    final synapses =
        (json['synapses'] as List?) ?? [];

    for (final item in synapses) {
      final map =
          Map<String, dynamic>.from(item);

      final from =
          brain.getNeuron(map['from']);

      final to =
          brain.getNeuron(map['to']);

      if (from == null || to == null) {
        continue;
      }

     final synapse = Synapse(
      id: map['id'],
      from: from,
      to: to,
      relationship:
          RelationshipType.values.firstWhere(
        (e) =>
            e.name ==
            map['relationship'],
      ),
      weight:
          (map['strength'] ?? 0.2)
              .toDouble(),
      plasticity:
          (map['plasticity'] ?? 1.0)
              .toDouble(),
      activationCount:
          map['activationCount'] ?? 0,
      lastActivated:
          map['lastActivated'] != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  map['lastActivated'],
                )
              : null,
);

      brain.addSynapse(synapse);
    }

    return brain;
  }
}