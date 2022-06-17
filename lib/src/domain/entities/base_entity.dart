import 'package:pautas/src/domain/interfaces/base_model_interface.dart';

abstract class BaseEntity extends IBaseModelInterface {
  String? id;

  BaseEntity();

  void assignValues(Map<String, dynamic> map);

  void copy(BaseEntity entity){
    assignValues(entity.toMap());
  }

}