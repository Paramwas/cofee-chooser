import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kendrick/models/user.dart';
import 'package:kendrick/services/brew.dart';
import 'package:riverpod/riverpod.dart';

class DatabaseService {
  final String uid;
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  DatabaseService({required this.uid});

  /// Update or create user data
  Future<void> updateUserData(String sugars, String name, int strength) async {
    await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    }, SetOptions(merge: true)); // 🔹 Merge updates instead of replacing data
  }

  /// Convert Firestore snapshot to Userdata model
  Userdata _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data()
        as Map<String, dynamic>?; // 🔹 Handle potential null data

    return Userdata(
      uid: uid,
      name: data?['name'] ?? 'Unknown',
      strength: data?['strength'] ?? 0,
      sugars: data?['sugars'] ?? 'None',
    );
  }

  /// Get real-time user data as a Stream
  Stream<Userdata> get userdata {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  /// Fetch all brews as a Stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Brew(
          name: data['name'] ?? 'Unknown',
          sugars: data['sugars'] ?? 'None',
          Strength: data['strength'] ?? 0,
        );
      }).toList();
    });
  }
}

/// Fetches all users' data
final naughtyProvider = StreamProvider<List<Userdata>>((ref) {
  return FirebaseFirestore.instance
      .collection('brews')
      .snapshots()
      .map((querySnapshot) {
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Userdata(
        uid: doc.id, // 🔹 Ensure UID is correctly assigned
        name: data['name'] ?? 'Unknown',
        strength: data['strength'] ?? 0,
        sugars: data['sugars'] ?? 'None',
      );
    }).toList();
  });
});

final WineProvider = StreamProvider<List<Brew>>((ref) {
  return FirebaseFirestore.instance
      .collection('brews')
      .snapshots()
      .map((snaps) {
    return snaps.docs.map((jite) {
      final lewa = jite.data() as Map<String, dynamic>;
      return Brew(
          Strength: lewa['strength'] ?? '',
          name: lewa['name'] ?? '',
          sugars: lewa['sugars'] ?? '');
    }).toList();
  });
});
