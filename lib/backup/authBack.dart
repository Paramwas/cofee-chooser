import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendrick/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class place {
  final FirebaseAuth _plat = FirebaseAuth.instance;

  Users? _Mapuser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users?> get userr {
    return _plat.authStateChanges().map(_Mapuser);
  }

  Future SiginEasily(String username, String password) async {
    UserCredential money = await _plat.signInWithEmailAndPassword(
        email: username, password: password);

    return _Mapuser(money.user);
  }
}

final makes = Provider((ref) => place());

final rogerProvider = StreamProvider<Users?>((ref) {
  return ref.watch(makes).userr;
});
