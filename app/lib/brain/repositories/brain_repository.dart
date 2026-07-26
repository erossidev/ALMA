import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';

abstract class BrainRepository {
  // =====================================================
  // SALVATAGGIO
  // =====================================================

  Future<void> saveNeuron(
    Neuron neuron,
  );

  Future<void> saveSynapse(
    Synapse synapse,
  );

  // =====================================================
  // ELIMINAZIONE
  // =====================================================

  Future<void> deleteSynapse(
    String synapseId,
  );

  // =====================================================
  // CARICAMENTO
  // =====================================================

  Future<Brain> loadBrain();

  // =====================================================
  // RESET
  // =====================================================

  Future<void> clearBrain();
}