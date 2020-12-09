import 'package:flushbar/flushbar.dart';
import 'package:flutter/widgets.dart';

class SnakeBar {
  static show(BuildContext context, {String message, String title, int duration=3}) {
    Flushbar(
      title: title,
      message: message,
      duration: Duration(seconds: duration),

    )
      ..show(context);
  }
}