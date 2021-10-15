import 'package:another_flushbar/flushbar.dart';
import 'package:app_posto_el/src/utils/types_toast.dart';
import 'package:flutter/material.dart';

class MeuToast {
  static Flushbar _flushbar = new Flushbar();

  static Flushbar toast(
      {required String title,
      required String message,
      required TypeToast type,
      required BuildContext context}) {
    _flushbar = Flushbar(
      duration: Duration(seconds: message.length >= 80 ? 6 : 4),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      title: title,
      backgroundColor: type == TypeToast.success
          ? Colors.green
          : type == TypeToast.noNet
              ? Color(0xFFFF7F26)
              : Color(0xffcf1f36),
      margin: EdgeInsets.all(20),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      icon: type == TypeToast.success
          ? Icon(
              Icons.beenhere,
              color: Colors.white,
            )
          : type == TypeToast.error
              ? Icon(
                  Icons.error,
                  color: Colors.white,
                )
              : Icon(
                  Icons.signal_wifi_connected_no_internet_4,
                  color: Colors.white,
                ),
    )..show(context);

    return _flushbar;
  }
}
