import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pautas/src/domain/entities/base_entity.dart';
import 'package:pautas/src/domain/interfaces/firebase_repository_base_interface.dart';

class FirebaseRepositoyBase<Entity extends BaseEntity> implements IFirebaseRepositoryBaseInterface<Entity>{

  FirebaseRepositoyBase({this.fromMap, this.collection}) {
    collectionReference = FirebaseFirestore.instance.collection(collection);
  }

  final Entity Function(Map map) fromMap;

  String collection;

  CollectionReference collectionReference;

  @override
  Future<String> add(Entity entity) async {
    var document = await collectionReference.add(entity.toMap());
    return document.id;
  }

  @override
  Future<void> update(Entity entity) async {
    await collectionReference.doc(entity.id).update(entity.toMap());
  }

  @override
  Future<void> delete(String documentId) async {
    await collectionReference.doc(documentId).delete();
  }

  @override
  Future<Entity> getById(String documentId) async {
    final snapshot = await collectionReference.doc(documentId).get();
    Entity entity = fromMap(snapshot.data());
    entity.id = snapshot.id;
    return entity;
  }

  @override
  Future<List<Entity>> getAll() async {
    List<Entity> list = [];
    final querySnapshot = await collectionReference.get();
    querySnapshot.docs.forEach((element) {
      Entity entity = fromMap(element.data());
      entity.id = element.id;
      list.add(entity);
    });

    return list;
  }

}