import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class User {
  static const String collectionName = "users";
  String? id;
  String? FullName;
  String? UserName;
  String? Email;

  User(this.id, this.FullName, this.UserName, this.Email);

  User.fromFireStore (Map<String , dynamic>? data){
    id = data?['id'];
    FullName = data?['fullname'];
    UserName = data?['username'];
    Email = data?['email'];


  }


  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'email': Email,
      'fullname': FullName,
      'username': UserName
    };
  }
}
