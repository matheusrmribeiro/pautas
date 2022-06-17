import 'package:pautas/src/domain/entities/guideline_entity.dart';
import 'firebase_base_repository.dart';

class GuidelinesRepository extends FirebaseRepositoyBase<GuidelineEntity?> {
  GuidelinesRepository({String collection = "guidelines"}) : super(collection: collection);


  @override
  String get collection => "guidelines";

  @override
  GuidelineEntity Function(Map? map) get fromMap => (map) => GuidelineEntity.fromMap(map as Map<String, dynamic>);

}