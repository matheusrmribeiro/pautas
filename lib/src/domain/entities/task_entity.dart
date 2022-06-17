import 'base_entity.dart';

class TaskEntity extends BaseEntity {

  TaskEntity({ 
    this.done = false, 
    this.text
  });

  bool? done;
  String? text;

  @override
  void assignValues(Map<String, dynamic> map) {
    done = map["done"];
    text = map["text"];
  }

  TaskEntity.fromMap(Map<String, dynamic> map) { assignValues(map); }

  @override
  Map<String, dynamic> toMap() => {
    "done": done,
    "text": text,
  };

}