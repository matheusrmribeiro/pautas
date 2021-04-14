import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/controllers/auth_controller.dart';
import 'package:pautas/src/domain/entities/user_entity.dart';

part 'user_cadastre_controller.g.dart';

class UserCadastreController = _UserCadastreControllerBase with _$UserCadastreController;

abstract class _UserCadastreControllerBase with Store {

  @observable
  Map<int, Function> stepsCallback = {};

  @observable
  int currentPage = 0;

  @observable
  UserEntity newUser = UserEntity();

  @observable
  bool finalized = false;

  @observable
  bool goToEmail = false;

  @action
  void addStepCallback(Function callback){
    stepsCallback[stepsCallback.length] = callback;
  }

  @action
  Future<void> registerUser(String password) async{
    final _auth = Modular.get<AuthController>();
    try{
      await _auth.registerUser(email: newUser.email, password: password, newUser: newUser);
    }
    catch (error) {
      finalized = false;
      goToEmail = true;
    }
  }
}
