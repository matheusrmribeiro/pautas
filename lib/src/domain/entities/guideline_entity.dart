import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pautas/src/domain/entities/base_entity.dart';
import 'package:pautas/src/domain/entities/task_entity.dart';

class GuidelineEntity extends BaseEntity{

  GuidelineEntity({ 
    this.title, 
    this.description, 
    this.done ,
    this.begin,
    this.end,
    this.tasks =  const []
  });

  String owner;
  String author;
  String title;
  String description;
  bool done;
  Timestamp begin;
  Timestamp end;
  List<TaskEntity> tasks;

  @override
  void assignValues(Map<String, dynamic> map) {
    owner = map["owner"];
    author = map["author"];
    title = map["title"];
    description = map["description"];
    done = map["done"];
    begin = map["begin"];
    end = map["end"];
    tasks = ((map["tasks"] ?? []) as List).map((e) => TaskEntity.fromMap(e)).toList();
  }

  GuidelineEntity.fromMap(Map<String, dynamic> map) { assignValues(map); }

  @override
  Map<String, dynamic> toMap() => {
    "owner": owner,
    "author": author,
    "title": title,
    "description": description,
    "done": done,
    "begin": begin,
    "end": end,
    "tasks": tasks.map((e) => e.toMap()).toList()
  };

}