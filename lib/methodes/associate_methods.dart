/*import 'package:flutter/material.dart';

class AssociateMethods {
  showSnackBarMsg(String msg, BuildContext cxt) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(cxt).showSnackBar(snackBar);
  }
}*/
import 'package:flutter/material.dart';

class AssociateMethods {
  static void showSnackBarMsg(String msg, BuildContext cxt) {
    var snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(cxt).showSnackBar(snackBar);
  }
}

