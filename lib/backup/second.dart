import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kendrick/models/user.dart';

class Easy {
  final FirebaseAuth oluwa = FirebaseAuth.instance;

  Users? Remas(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  Future _Logins() async {
    final womans = await oluwa.signInAnonymously();
    User? user = womans.user;
    return Remas(user);
  }

  Stream<Users?> get boom {
    return oluwa.authStateChanges().map(Remas);
  }
}

final stupity = Provider((ref) => Easy());
final mansProvider = StreamProvider<Users?>((ref) {
  return ref.watch(stupity).boom;
});
