import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';

abstract class BrainRepository {
  Future<void> saveNeuron(Neuron neuron);

  Future<void> saveSynapse(Synapse synapse);

  Future<Brain> loadBrain();

  Future<void> clearBrain();
}