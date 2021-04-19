import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/controllers/auth_controller.dart';
import 'package:pautas/src/app/utils/enums.dart';
import 'package:pautas/src/app/widgets/toast.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  AuthStatus statusEmail = AuthStatus.logoff;

  dispose() {}

  @action
  onLoginEmailPassword() async {
    if (email.isEmpty){
      Toast.showMessage("Informe o email!", duration: 5, toastKind: ToastKind.error);
      return;
    }
      

    if (password.isEmpty){
      Toast.showMessage("Informe a senha!", duration: 5, toastKind: ToastKind.error);
      return;
    }

    try {
      statusEmail = AuthStatus.loading;
      await Modular.get<AuthController>().loginWithEmailPassword(email: email, password: password).then((_) {
        if (Modular.get<AuthController>().firebaseUser != null)
          _openRoot();
        else
          statusEmail = AuthStatus.logoff;
      });

    } catch (error) {
      statusEmail = AuthStatus.logoff;

      switch (error.code) {
        case "invalid-email":
          Toast.showMessage("Email ou senha incorreto!", duration: 5, toastKind: ToastKind.error);
          break;
        case "wrong-password":
          Toast.showMessage("Email ou senha incorreto!", duration: 5, toastKind: ToastKind.error);
          break;
        case "user-not-found":
          Toast.showMessage("Email não encontrado.", duration: 5, toastKind: ToastKind.error);
          break;  
        default:
          Toast.showMessage("Erro desconhecido ao fazer o login.", duration: 5, toastKind: ToastKind.error);
      }
    }
  }

  onForgotPass() {
    Modular.to.pushNamed('/forgotpass');
  }

  onRegister() {
    Modular.to.pushNamed('/register');
  }

  _openRoot() {
    Modular.to.pushReplacementNamed('/root');
  }

}
