import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/ui/Login/loginScreen.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';

class splash extends StatelessWidget{

   static const String routeName = "splash";

  @override
  Widget build(BuildContext context) {
Future.delayed(Duration(seconds: 3),() {
  navigate(context);
},);

    return Scaffold(
body: Image(image: AssetImage("assets/images/img.png")),
    );
  }

  void navigate(BuildContext context) async {
    var authProvider  = Provider.of<AuthProvider>(context , listen: false);
    if ( authProvider.IsUserLoggedInBefore()){
      await authProvider.retrieveUserFromDatabase();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
    else Navigator.pushReplacementNamed(context, login.routeName);

  }
}