import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(context, {bool isCancelable = true}) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10),
                Text("Loading..."),
              ],
            ),
          );
        },
        barrierDismissible: isCancelable);
  }

  static void hideDialog(context) {
    Navigator.pop(context);
  }

  static void showMessage(context, String message,
      {String? posActionTitle,
      String? negActionTitle,
        VoidCallback? posAction,
        VoidCallback? negAction,
      bool isCancelable = true})

  {
    List<Widget>actions = [];
    if ( posActionTitle!=null ){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      }, child: Text(posActionTitle)));
    }
    if ( negActionTitle!=null ){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      }, child: Text(negActionTitle)));
    }

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: actions,
            content: Row(
              children: [
                Text(message),
              ],
            ),
          );
        },
        barrierDismissible: isCancelable);
  }
}
