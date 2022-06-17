import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  User? getUser();
  Future<User?> getEmailPasswordLogin({String? email, String? password});
  Future<void> registerEmailPassword({String? email, String? password});
  Future logOut();
}