import 'brain_vocabulary.dart';

import 'neuron.dart';
import 'synapse.dart';

import 'dynamics/neuron_dynamics.dart';
import 'dynamics/synapse_dynamics.dart';

class Brain {
  /// ==========================
  /// RETE COGNITIVA
  /// ==========================

  final Map<String, Neuron> _neurons = {};
  final Map<String, Synapse> _synapses = {};

  /// ==========================
  /// STATO
  /// ==========================

  bool _dirty = false;

  bool get isDirty => _dirty;

  void markDirty() {
    _dirty = true;
  }

  void clearDirty() {
    _dirty = false;
  }

  /// ==========================
  /// GETTERS
  /// ==========================

  Iterable<Neuron> get neurons => _neurons.values;

  Iterable<Synapse> get synapses => _synapses.values;

  int get neuronCount => _neurons.length;

  int get synapseCount => _synapses.length;

  /// ==========================
  /// GESTIONE NEURONI
  /// ==========================

  void addNeuron(
    Neuron neuron,
  ) {
    _neurons[neuron.id] = neuron;
    markDirty();
  }

  void removeNeuron(
    String id,
  ) {
    _neurons.remove(id);

    _synapses.removeWhere(
      (_, synapse) =>
          synapse.from.id == id ||
          synapse.to.id == id,
    );

    markDirty();
  }

  bool containsNeuron(
    String id,
  ) {
    return _neurons.containsKey(id);
  }

  Neuron? getNeuron(
    String id,
  ) {
    return _neurons[id];
  }

  Neuron? findNeuronByLabel(
    String label,
  ) {
    try {
      return _neurons.values.firstWhere(
        (n) =>
            n.label.toLowerCase() ==
            label.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// ==========================
  /// GESTIONE SINAPSI
  /// ==========================

  void addSynapse(
    Synapse synapse,
  ) {
    _synapses[synapse.id] = synapse;
    markDirty();
  }

  void removeSynapse(
    String id,
  ) {
    _synapses.remove(id);
    markDirty();
  }

  bool containsSynapse(
    String id,
  ) {
    return _synapses.containsKey(id);
  }

  Synapse? getSynapse(
    String id,
  ) {
    return _synapses[id];
  }

  /// ==========================
  /// REMOVE CONNECTIONS
  /// (Per replace)
  /// ==========================

  List<Synapse> removeConnections({
    required String from,
    required RelationshipType relationship,
  }) {
    final removed = <Synapse>[];

    final ids = _synapses.values
        .where(
          (synapse) =>
              synapse.from.id == from &&
              synapse.relationship ==
                  relationship,
        )
        .map(
          (e) => e.id,
        )
        .toList();

    for (final id in ids) {
      final synapse =
          _synapses.remove(id);

      if (synapse != null) {
        removed.add(synapse);
      }
    }

    if (removed.isNotEmpty) {
      markDirty();
    }

    return removed;
  }

  /// ==========================
  /// CONNESSIONI
  /// ==========================

  void connect(
    Synapse synapse,
  ) {
    if (_synapses.containsKey(
      synapse.id,
    )) {
      SynapseDynamics.reinforce(
        _synapses[synapse.id]!,
      );

      markDirty();

      return;
    }

    _synapses[synapse.id] = synapse;

    markDirty();
  }

  List<Synapse> getConnections(
    String neuronId,
  ) {
    return _synapses.values.where(
      (synapse) {
        return synapse.from.id ==
                neuronId ||
            synapse.to.id ==
                neuronId;
      },
    ).toList();
  }

  List<Neuron> getRelatedNeurons(
    String neuronId,
  ) {
    final result = <Neuron>[];

    for (final synapse in _synapses.values) {
      if (synapse.from.id ==
          neuronId) {
        result.add(
          synapse.to,
        );
      }

      if (synapse.to.id ==
          neuronId) {
        result.add(
          synapse.from,
        );
      }
    }

    return result;
  }

  /// ==========================
  /// ATTIVAZIONE
  /// ==========================

  void activateNeuron(
    String neuronId, [
    double stimulus = 1.0,
  ]) {
    final neuron =
        getNeuron(neuronId);

    if (neuron == null) {
      return;
    }

    NeuronDynamics.activate(
      neuron,
      stimulus: stimulus,
    );

    markDirty();
  }

  /// ==========================
  /// PROPAGAZIONE
  /// ==========================

  void propagate(
    String neuronId,
  ) {
    final connections =
        getConnections(neuronId);

    for (final synapse
        in connections) {
      SynapseDynamics.activate(
        synapse,
      );

      final target =
          synapse.from.id ==
                  neuronId
              ? synapse.to
              : synapse.from;

      NeuronDynamics.activate(
        target,
        stimulus:
            synapse.weight,
      );
    }

    markDirty();
  }

  /// ==========================
  /// DECAY
  /// ==========================

  void decayAll() {
    for (final neuron
        in _neurons.values) {
      NeuronDynamics.decay(
        neuron,
      );
    }

    for (final synapse
        in _synapses.values) {
      SynapseDynamics.decay(
        synapse,
      );
    }

    markDirty();
  }

  /// ==========================
  /// COPY
  /// ==========================

  void copyFrom(
    Brain other,
  ) {
    _neurons.clear();
    _synapses.clear();

    for (final neuron
        in other.neurons) {
      _neurons[neuron.id] =
          neuron;
    }

    for (final synapse
        in other.synapses) {
      _synapses[synapse.id] =
          synapse;
    }

    clearDirty();
  }

  /// ==========================
  /// DEBUG
  /// ==========================

  @override
  String toString() {
    return '''
Brain
------
Neurons : $neuronCount
Synapses: $synapseCount
Dirty    : $isDirty
''';
  }
}