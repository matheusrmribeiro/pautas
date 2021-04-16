import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pautas/src/domain/entities/base_entity.dart';

class GuidelineEntity extends BaseEntity{

  GuidelineEntity({ this.title, this.description, this.done });

  String owner;
  String author;
  String title;
  String description;
  String details;
  bool done;
  Timestamp begin;
  Timestamp end;

  @override
  void assignValues(Map<String, dynamic> map) {
    owner = map["owner"];
    author = map["author"];
    title = map["title"];
    description = map["description"];
    details = map["details"];
    done = map["done"];
    begin = map["begin"];
    end = map["end"];
  }

  GuidelineEntity.fromMap(Map<String, dynamic> map) { assignValues(map); }

  @override
  Map<String, dynamic> toMap() => {
    "owner": owner,
    "author": author,
    "title": title,
    "description": description,
    "details": details,
    "done": done,
    "begin": begin,
    "end": end
  };

}