import 'package:firebase_auth/firebase_auth.dart';
import 'package:dishcord/log_in/auth/auth_state.dart';
import 'package:dishcord/log_in/user/user_creation_service.dart';
import 'package:dishcord/firestore/model/user.dart' as UserModel;

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final UserCreationService _userCreationService;

  AuthService(this._firebaseAuth, this._userCreationService);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<AuthState> logIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthState(AuthStatus.authed, null);
    } on FirebaseAuthException catch (e) {
      return AuthState(AuthStatus.error, e.message);
    }
  }

  Future<AuthState> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _userCreationService.createUser(email);
      return AuthState(AuthStatus.authed, null);
    } on FirebaseAuthException catch (e) {
      return AuthState(AuthStatus.error, e.message);
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
