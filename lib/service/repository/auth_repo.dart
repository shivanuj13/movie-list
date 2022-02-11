//todo: it is for the google authentication

import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<User?> signInWithGoogle();
  void signOut();
}
