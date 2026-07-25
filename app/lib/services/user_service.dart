import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOrUpdateUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final docRef = _firestore.collection('users').doc(user.uid);

    final doc = await docRef.get();

    if (!doc.exists) {
      // Primo accesso
      await docRef.set({
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'plan': 'free',
      });
    } else {
      // Accessi successivi
      await docRef.update({
        'lastLogin': FieldValue.serverTimestamp(),
      });
    }
  }
}