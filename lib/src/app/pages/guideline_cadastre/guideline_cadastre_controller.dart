import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pautas/src/app/utils/enums.dart';
import 'package:pautas/src/app/widgets/toast.dart';
import 'package:pautas/src/data/repositories/guidelines_repository.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';
import 'package:pautas/src/domain/entities/task_entity.dart';
import 'package:pautas/src/domain/entities/user_entity.dart';

part 'guideline_cadastre_controller.g.dart';

class GuidelineCadastreController = _UserCadastreControllerBase with _$GuidelineCadastreController;

abstract class _UserCadastreControllerBase with Store {

  PageController pageController = PageController();

  @observable
  Map<int, Function> stepsCallback = {};

  @observable
  int currentPage = 0;

  @observable
  GuidelineEntity newGuideline = GuidelineEntity();

  @observable
  ObservableList<TaskEntity> tasks = <TaskEntity>[].asObservable();

  final GuidelinesRepository _repository = GuidelinesRepository();

  void setGuideline(GuidelineEntity guideline) {
    newGuideline = guideline;
    tasks = guideline.tasks.asObservable();
  }

  @action
  void addTask(TaskEntity task){
    tasks.add(task);
  }

  @action
  void addStepCallback(Function callback){
    if (!stepsCallback.containsValue(callback))
      stepsCallback[stepsCallback.length] = callback;
  }

  @action
  Future<void> addGuideline() async {
    newGuideline.done = false;
    newGuideline.owner = Modular.get<UserEntity>().id;
    newGuideline.author = Modular.get<UserEntity>().name;
    newGuideline.tasks = tasks;
    
    try{
      if (newGuideline.id == null) {
        await _repository.add(newGuideline);
        Toast.showMessage("Nova pauta adicionada!", duration: 5, toastKind: ToastKind.success);
        Modular.to.pop();
      } else {
        await _repository.update(newGuideline);
        Toast.showMessage("Pauta atualizada!", duration: 5 ,toastKind: ToastKind.success);
        Modular.to.pop(newGuideline);
      }
    }
    catch (error) {
      Toast.showMessage("Oops! Parece que houve um problema ao inserir a pauta :(", duration: 5);
    }
  }

  void nextPage() async {
    if (await stepsCallback[currentPage]())
     pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }

}
