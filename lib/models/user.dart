import 'package:app/models/person.dart';

class User {
  //TODO: complete user structure
  final String? id;
  final String? userName; 
  final String? password;
  final Person? person;
  final String? mainRole;
  final List<String> roles;
  String? photoUrl;
  
  User({
    this.id,
    this.userName,
    this.password,
    required this.person,
    this.mainRole,
    required this.roles,
    this.photoUrl
  });
}