import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/CustomFormField.dart';
import 'package:todo_app/database/UserDao.dart';
import 'package:todo_app/database/model/user.dart' as MyUser;
import 'package:todo_app/providers/authProvider/AuthProvider.dart';
import 'package:todo_app/ui/DialogUtils.dart';
import 'package:todo_app/ui/Login/loginScreen.dart';
import 'package:todo_app/ui/home/HomeScreen.dart';

import '../../ValidationUtils.dart';

class registerScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  TextEditingController FullName = TextEditingController();

  TextEditingController UserName = TextEditingController();

  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();

  TextEditingController PasswordConfirmation = TextEditingController();

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
                    hintText: "FullName",
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter Your Name";
                      }
                      return null;
                    },
                    controller: FullName,
                  ),
                  CustomFormFeild(
                    hintText: "UserName",
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter Your UserName";
                      }
                      return null;
                    },
                    controller: UserName,
                  ),
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
                  CustomFormFeild(
                    hintText: "Confirm Password",
                    secureText: true,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      if (text.length < 6) {
                        return "Password should be 6 characters or more";
                      }
                      if (text != Password.text) {
                        return "Password Doesn't Match! ";
                      }
                      return null;
                    },
                    controller: PasswordConfirmation,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      child: const Text("Sign UP")),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, login.routeName);
                  }, child: Text("Already Have account ?"))
                ],
              ),
            ),
          ),
        ));
  }

  void createAccount() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authProvider =  Provider.of<AuthProvider>(context , listen: false);
    try {
      DialogUtils.showLoading(context);
      await authProvider.register(Email.text, Password.text, FullName.text, UserName.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, "Registered In Sucessfully",
          posActionTitle: "OK", posAction: () {
        Navigator.pushReplacementNamed(context, login.routeName);
      }, negActionTitle: "BACK");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtils.showMessage(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessage(
            context, 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
