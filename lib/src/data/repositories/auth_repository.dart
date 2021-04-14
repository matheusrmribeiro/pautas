import 'package:firebase_auth/firebase_auth.dart';
import 'package:pautas/src/domain/interfaces/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  @override
  Future<void> registerEmailPassword({String email, String password}) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
  }

  @override
  Future<User> getEmailPasswordLogin({String email, String password}) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    return firebaseAuth.currentUser;
  }

  @override
  Future logOut() async {
    return await firebaseAuth.signOut();
  }

  User getUser() {
    return firebaseAuth.currentUser;
  }

}
