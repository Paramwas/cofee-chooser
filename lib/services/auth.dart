import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendrick/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kendrick/services/database.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendrick/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _uidFromFirebaseUser(User? user) {
    return user?.uid;
  }

  Stream<String?> get userUid {
    return _auth.authStateChanges().map(_uidFromFirebaseUser);
  }

  Future<String?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return _uidFromFirebaseUser(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? uid = _uidFromFirebaseUser(result.user);
      if (uid != null) {
        await DatabaseService(uid: uid).updateUserData('0', 'new user', 100);
      }
      return uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}

final authProvider = Provider((ref) => AuthService());

final authStateProvider = StreamProvider<String?>((ref) {
  return ref.watch(authProvider).userUid;
});
