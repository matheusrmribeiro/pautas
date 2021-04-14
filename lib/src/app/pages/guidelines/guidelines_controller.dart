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

  @action
  Future<void> getData() async {
    List<GuidelineEntity> itens = [];
    
    final querySnapshot = await _repository.collectionReference.where("done", isEqualTo: done).get();
    querySnapshot.docs.forEach((element) {
      GuidelineEntity entity = GuidelineEntity.fromMap(element.data());
      entity.id = element.id;
      itens.add(entity);
    });

    guidelines = itens;
  }

  @action
  void updateGuideline(GuidelineEntity guidelineUpdated){
    guidelines.singleWhere((element) => element.id == guidelineUpdated.id).copy(guidelineUpdated);
  }

  @action
  void updateStatus(GuidelineEntity guideline){
    _repository.update(guideline);
  }

}