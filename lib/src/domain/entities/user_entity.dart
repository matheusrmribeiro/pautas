import 'package:pautas/src/domain/entities/base_entity.dart';

class UserEntity extends BaseEntity{
  
  UserEntity({
    this.name,
    this.email,
  });
  
  String name;
  String email;
  String password;

  @override
  void assignValues(Map<String, dynamic> map) {
    name = map["name"];
    email = map["email"];
  }

  UserEntity.fromMap(Map<String, dynamic> map) { assignValues(map); }

  Map<String, dynamic> toMap() => {
    "name" : "$name",
    "email" : "$email",
  };

  UserEntity setUser(UserEntity user) {
    name = user.name;
    email = user.email;
    
    return this;
  }

}