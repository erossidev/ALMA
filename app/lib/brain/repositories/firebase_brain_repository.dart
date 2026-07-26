import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../brain.dart';
import '../neuron.dart';
import '../synapse.dart';
import 'brain_repository.dart';

class FirebaseBrainRepository implements BrainRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>>
      get _neurons => _firestore
          .collection('users')
          .doc(_uid)
          .collection('brain')
          .doc('memory')
          .collection('neurons');

  CollectionReference<Map<String, dynamic>>
      get _synapses => _firestore
          .collection('users')
          .doc(_uid)
          .collection('brain')
          .doc('memory')
          .collection('synapses');

  // =====================================================
  // SALVATAGGIO NEURONE
  // =====================================================

  @override
  Future<void> saveNeuron(
    Neuron neuron,
  ) async {
    print(">>> SALVO NEURONE: ${neuron.id}");

    await _neurons.doc(neuron.id).set(
      neuron.toJson(),
    );
  }

  // =====================================================
  // SALVATAGGIO SINAPSI
  // =====================================================

  @override
  Future<void> saveSynapse(
    Synapse synapse,
  ) async {
    print(">>> SALVO SINAPSI: ${synapse.id}");

    await _synapses.doc(synapse.id).set(
      synapse.toJson(),
    );
  }

  // =====================================================
  // ELIMINA SINAPSI
  // =====================================================

  @override
  Future<void> deleteSynapse(
    String synapseId,
  ) async {
    print(">>> ELIMINO SINAPSI: $synapseId");

    await _synapses.doc(synapseId).delete();
  }

  // =====================================================
  // CARICAMENTO BRAIN
  // =====================================================

  @override
  Future<Brain> loadBrain() async {
    final brain = Brain();

    final neuronSnapshot =
        await _neurons.get();

    for (final doc in neuronSnapshot.docs) {
      final neuron = Neuron.fromJson(
        doc.data(),
      );

      brain.addNeuron(neuron);
    }

    final synapseSnapshot =
        await _synapses.get();

    for (final doc in synapseSnapshot.docs) {
      final synapse = Synapse.fromJson(
        json: doc.data(),
        brain: brain,
      );

      brain.addSynapse(synapse);
    }

    brain.clearDirty();

    return brain;
  }

  // =====================================================
  // ELIMINA MEMORIA
  // =====================================================

  @override
  Future<void> clearBrain() async {
    final neuronSnapshot =
        await _neurons.get();

    for (final doc in neuronSnapshot.docs) {
      await doc.reference.delete();
    }

    final synapseSnapshot =
        await _synapses.get();

    for (final doc in synapseSnapshot.docs) {
      await doc.reference.delete();
    }
  }
}