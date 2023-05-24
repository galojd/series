import 'package:flutter/material.dart';

class NotificationServices {
  static GlobalKey<ScaffoldMessengerState> messengerkey =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackbar = new SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ));
    messengerkey.currentState!.showSnackBar(snackbar);
  }
}
