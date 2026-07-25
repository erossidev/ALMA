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
      get _neurons =>
          _firestore
              .collection('users')
              .doc(_uid)
              .collection('brain')
              .doc('memory')
              .collection('neurons');

  CollectionReference<Map<String, dynamic>>
      get _synapses =>
          _firestore
              .collection('users')
              .doc(_uid)
              .collection('brain')
              .doc('memory')
              .collection('synapses');

  @override
  Future<void> saveNeuron(
    Neuron neuron,
  ) async {
    await _neurons.doc(neuron.id).set(
          neuron.toJson(),
        );
  }

  @override
  Future<void> saveSynapse(
    Synapse synapse,
  ) async {
    await _synapses.doc(synapse.id).set(
          synapse.toJson(),
        );
  }

  @override
  Future<Brain> loadBrain() async {
    final brain = Brain();

    // IMPLEMENTEREMO QUESTO NELLO STEP SUCCESSIVO

    return brain;
  }

  @override
  Future<void> clearBrain() async {
    // IMPLEMENTEREMO DOPO
  }
}