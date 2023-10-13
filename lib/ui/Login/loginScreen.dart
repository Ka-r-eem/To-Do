import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/CustomFormField.dart';
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/ui/DialogUtils.dart';
import 'package:todo_app/ui/Register/registerScreen.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';

import '../../ValidationUtils.dart';

class login extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/backGround.png"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomFormFeild(
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter Your Email";
                      }
                      if (!isValidEmail(text)) {
                        return "Email Format not Valid";
                      }

                      return null;
                    },
                    controller: Email,
                  ),
                  CustomFormFeild(
                    hintText: "Password",
                    secureText: true,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      if (text.length < 6) {
                        return "Password should be 6 characters or more";
                      }
                      return null;
                    },
                    controller: Password,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Login();
                      },
                      child: const Text("Login")),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, registerScreen.routeName);
                      },
                      child: Text("Don't Have Account ?"))
                ],
              ),
            ),
          ),
        ));
  }

  void Login() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authProvider = Provider.of<AuthProvider>(context ,listen: false );
    try {
      DialogUtils.showLoading(context, isCancelable: false);
      await authProvider.login(Email.text, Password.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, "LOGGED IN SUCCESS",
          posActionTitle: "OK", posAction: () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }, negActionTitle: "BACK");
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == "INVALID_LOGIN_CREDENTIALS") {
        print(e.code);
        DialogUtils.showMessage(context, "Wrong Email or Password",
            posActionTitle: "OK");
      }
    }
  }
}
