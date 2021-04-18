import 'package:mobx/mobx.dart';
import 'package:pautas/src/data/repositories/firebase_base_repository.dart';
import 'package:pautas/src/domain/entities/guideline_entity.dart';

part 'guidelines_controller.g.dart';

class GuidelinesController = _GuidelinesControllerBase with _$GuidelinesController;

abstract class _GuidelinesControllerBase with Store {
  
  _GuidelinesControllerBase({ this.done = true });

  final bool done;

  final FirebaseRepositoyBase _repository = FirebaseRepositoyBase<GuidelineEntity>(
    collection: "guidelines", 
    fromMap: (map) => GuidelineEntity.fromMap(map)
  );

  @observable
  List<GuidelineEntity> guidelines = [];

  @observable
  bool loading = false;

  @action
  Future<void> getData() async {
    loading = true;
    List<GuidelineEntity> itens = [];
    
    final querySnapshot = await _repository.collectionReference.where("done", isEqualTo: done).get();
    querySnapshot.docs.forEach((element) {
      GuidelineEntity entity = GuidelineEntity.fromMap(element.data());
      entity.id = element.id;
      itens.add(entity);
    });

    guidelines = itens;
    loading = false;
  }

  @action
  void changeStatus(GuidelineEntity guideline) {
    guideline.done = !guideline.done;
    guideline.tasks.forEach((element) { element.done = guideline.done; });
    update(guideline);
    getData();
  }

  @action
  void updateTask(GuidelineEntity guideline) {
    if (guideline.done) {
      if (guideline.tasks.where((element) => !element.done).isNotEmpty)
        guideline.done = false;
    }
    update(guideline);
  }

  @action
  void update(GuidelineEntity guideline) {
    _repository.update(guideline);
  }

  @action
  void deleteGuideline(GuidelineEntity guideline) {
    _repository.delete(guideline.id);
  }

}