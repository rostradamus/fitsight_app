import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class GlobalExceptionUIHandler {
  static void showUnexpectedErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(FlutterI18n.translate(
              context, "http.errors.unexpected_error.title")),
          content: Text(FlutterI18n.translate(
              context, "http.errors.unexpected_error.content")),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  static void showSessionExpiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            FlutterI18n.translate(
              context,
              "http.errors.session_expired.title",
            ),
          ),
          content: Text(
            FlutterI18n.translate(
              context,
              "http.errors.session_expired.content",
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (r) => false);
              },
            ),
          ],
        );
      },
    );
  }
}
