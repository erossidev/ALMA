import 'neuron.dart';
import 'synapse.dart';

class Brain {
  /// ==========================
  /// RETE COGNITIVA
  /// ==========================

  final Map<String, Neuron> _neurons = {};
  final Map<String, Synapse> _synapses = {};

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

  void addNeuron(Neuron neuron) {
    _neurons[neuron.id] = neuron;
  }

  void removeNeuron(String id) {
    _neurons.remove(id);

    _synapses.removeWhere(
      (_, synapse) =>
          synapse.from.id == id ||
          synapse.to.id == id,
    );
  }

  bool containsNeuron(String id) {
    return _neurons.containsKey(id);
  }

  Neuron? getNeuron(String id) {
    return _neurons[id];
  }

  Neuron? findNeuronByLabel(String label) {
    try {
      return _neurons.values.firstWhere(
        (n) => n.label.toLowerCase() == label.toLowerCase(),
      );
    } catch (_) {
      return null;
    }
  }

  /// ==========================
  /// GESTIONE SINAPSI
  /// ==========================

  void addSynapse(Synapse synapse) {
    _synapses[synapse.id] = synapse;
  }

  void removeSynapse(String id) {
    _synapses.remove(id);
  }

  bool containsSynapse(String id) {
    return _synapses.containsKey(id);
  }

  Synapse? getSynapse(String id) {
    return _synapses[id];
  }

  /// ==========================
  /// CONNESSIONI
  /// ==========================

  void connect(Synapse synapse) {
    if (_synapses.containsKey(synapse.id)) {
      _synapses[synapse.id]!.strengthen();
      return;
    }

    _synapses[synapse.id] = synapse;
  }

  List<Synapse> getConnections(String neuronId) {
    return _synapses.values.where((synapse) {
      return synapse.from.id == neuronId ||
          synapse.to.id == neuronId;
    }).toList();
  }

  List<Neuron> getRelatedNeurons(String neuronId) {
    final List<Neuron> result = [];

    for (final synapse in _synapses.values) {
      if (synapse.from.id == neuronId) {
        result.add(synapse.to);
      }

      if (synapse.to.id == neuronId) {
        result.add(synapse.from);
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
    final neuron = getNeuron(neuronId);

    if (neuron == null) return;

    neuron.state.activate(stimulus);
  }

  /// ==========================
  /// PROPAGAZIONE (Versione 1)
  /// ==========================

  void propagate(String neuronId) {
    final connections = getConnections(neuronId);

    for (final synapse in connections) {
      synapse.activate();

      final target = synapse.from.id == neuronId
          ? synapse.to
          : synapse.from;

      target.state.activate(
        synapse.strength,
      );
    }
  }

  /// ==========================
  /// RESET ATTIVAZIONE
  /// ==========================

  void decayAll() {
    for (final neuron in _neurons.values) {
      neuron.state.decay();
    }

    for (final synapse in _synapses.values) {
      synapse.decay();
    }
  }

  /// ==========================
  /// STATISTICHE
  /// ==========================

  @override
  String toString() {
    return '''
Brain
------
Neurons : $neuronCount
Synapses: $synapseCount
''';
  }
}
