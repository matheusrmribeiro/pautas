import 'package:pautas/src/domain/entities/guideline_entity.dart';
import 'firebase_base_repository.dart';

class GuidelinesRepository extends FirebaseRepositoyBase<GuidelineEntity> {

  @override
  String get collection => "guidelines";

  @override
  GuidelineEntity Function(Map map) get fromMap => (map) => GuidelineEntity.fromMap(map);

}