import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential> creatUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }
}
