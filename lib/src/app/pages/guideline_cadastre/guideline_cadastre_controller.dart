import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/utils/enums.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import 'package:pautas/src/data/repositories/guidelines_repository.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';

part 'guideline_cadastre_controller.g.dart';

class GuidelineCadastreController = _UserCadastreControllerBase with _$GuidelineCadastreController;

abstract class _UserCadastreControllerBase with Store {

  @observable
  Map<int, Function> stepsCallback = {};

  @observable
  int currentPage = 0;

  @observable
  GuidelineEntity newGuideline = GuidelineEntity();

  final GuidelinesRepository _repository = GuidelinesRepository();

  @action
  void addStepCallback(Function callback){
    stepsCallback[stepsCallback.length] = callback;
  }

  @action
  Future<void> addGuideline() async {
    try{
      await _repository.add(newGuideline);
      Toast.showMessage("Nova pauta adicionada!", duration: 5,toastKind: ToastKind.success);
      Modular.to.pop();
    }
    catch (error) {
      Toast.showMessage("Oops! Parece que houve um problema ao inserir a pauta :(", duration: 5);
    }
  }
}
