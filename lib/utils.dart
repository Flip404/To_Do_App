import 'package:flutter/material.dart';

class Utils {

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(
        text,
        style: const TextStyle(
          color: Color.fromRGBO(248, 248, 255, 1),
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: const Color.fromRGBO(146, 42, 49, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
    messengerKey.currentState!..removeCurrentSnackBar()..showSnackBar(snackBar);
  }
}
