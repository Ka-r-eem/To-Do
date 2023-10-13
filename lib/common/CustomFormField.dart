import 'package:flutter/material.dart';

typedef Validator = String? Function (String?);

class CustomFormFeild extends StatelessWidget {

  String hintText;
  TextInputType keyboardType;
  bool secureText;
  Validator? validator;
  TextEditingController? controller;
  int lines ;
  CustomFormFeild(
      {required this.hintText,
      this.keyboardType = TextInputType.text,
      this.secureText = false ,
      this.validator,
      this.controller,
      this.lines = 1}) {}

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: lines,
      minLines: lines,
      controller: controller,
      validator: validator ,
      decoration: InputDecoration(label: Text(hintText)),
      keyboardType: keyboardType,
    );
  }
}
