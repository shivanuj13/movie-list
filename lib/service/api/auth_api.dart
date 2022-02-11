import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/service/repository/auth_repo.dart';

class AuthApi implements AuthRepo {
  AuthApi._();
  static final AuthApi _authApi = AuthApi._();
  factory AuthApi() => _authApi;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? account = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? signInAuthentication =
          await account?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: signInAuthentication?.accessToken,
          idToken: signInAuthentication?.idToken);
      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      await GoogleSignIn().disconnect();
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
