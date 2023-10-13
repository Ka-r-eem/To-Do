import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/database/model/user.dart' as MyUser;

import '../../database/UserDao.dart';

class AuthProvider extends ChangeNotifier {


  User? firebaseUser;
  MyUser.User? databaseUser;


  Future<void> register(String email, String password, String fullname,
      String username) async {
    var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    await UserDoa.createUser(MyUser.User(
        result.user?.uid, fullname, username, email));
  }

  Future<void> login(String email, String password) async {
    var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
    var user = await UserDoa.getUser(credential.user?.uid);
    databaseUser = user;
    firebaseUser = credential.user;
  }

  void logout() {
    databaseUser = null;
    FirebaseAuth.instance.signOut();
  }

  bool IsUserLoggedInBefore() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future <void> retrieveUserFromDatabase() async {
    firebaseUser = FirebaseAuth.instance.currentUser;
    databaseUser = await UserDoa.getUser(firebaseUser?.uid);
  }
}