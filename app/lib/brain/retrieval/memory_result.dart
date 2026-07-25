import '../neuron.dart';
import '../synapse.dart';

class MemoryResult {
  final List<Neuron> neurons;
  final List<Synapse> synapses;

  const MemoryResult({
    required this.neurons,
    required this.synapses,
  });

  bool get isEmpty =>
      neurons.isEmpty && synapses.isEmpty;

  bool get isNotEmpty => !isEmpty;
}