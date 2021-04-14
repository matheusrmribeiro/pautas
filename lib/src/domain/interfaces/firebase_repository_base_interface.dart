import 'dart:async';
import 'base_model_interface.dart';

abstract class IFirebaseRepositoryBaseInterface<Entity extends IBaseModelInterface> {

  Future<String> add(Entity model);

  Future<void> update(Entity model);

  Future<void> delete(String documentId);

  Future<List<Entity>> getAll();

  Future<Entity> getById(String documentId);

}