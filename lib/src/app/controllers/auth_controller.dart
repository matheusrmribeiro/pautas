import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/utils/enums.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import 'package:pautas/src/domain/entities/user_entity.dart';
import 'package:pautas/src/domain/interfaces/auth_repository_interface.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository _authRepository = Modular.get();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  User firebaseUser;
  
  @action
  setFirebaseUser(User value) async{
    firebaseUser = value;
    if (firebaseUser == null)
      status = AuthStatus.logoff;
    else{
      await setUser();
      status = AuthStatus.login;
    }
  }

  @action
  setUser() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("users").doc(firebaseUser.uid).get();
    Modular.get<UserEntity>().setUser(UserEntity.fromMap(doc.data()))..id = doc.id;    
  }

  _AuthControllerBase() {
    initialize();
  }

  @action
  Future<void> initialize() async {
    await setFirebaseUser(_authRepository.getUser());
  }

  @action
  Future loginWithEmailPassword({String email, String password}) async {
    firebaseUser = await _authRepository.getEmailPasswordLogin(email: email, password: password);
    await setUser();
  }

  @action
  Future registerUser({String email, String password, UserEntity newUser}) async {
    await _authRepository.registerEmailPassword(email: email, password: password);
    await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).set(newUser.toMap());
    await logout(goToLogin: false);
    Toast.showMessage("Usuário criado com sucesso!", duration: 5, toastKind: ToastKind.success);
    Modular.to.pop();
  }  

  @action
  Future logout({goToLogin = true}) async {
    await _authRepository.logOut();
    firebaseUser = null;
    if (goToLogin){
      Modular.to.popUntil((route) => route.isFirst);
      Modular.to.pushReplacementNamed('/login');
    }
  }

}