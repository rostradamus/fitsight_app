import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolog_app/blocs/auth/auth_bloc.dart';
import 'package:wolog_app/blocs/auth/auth_state.dart';
import 'package:wolog_app/utils/i18n.dart';
import 'package:wolog_app/widgets/components/login/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
          } else if (state is LoginFailureState) {
            var contentText = (state.statusCode == HttpStatus.unauthorized)
                ? I18n.UNAUTHENTICATED
                : I18n.UNEXPECTED;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Try Again"),
                  content: Text(contentText),
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
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(100.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: Text(
                      "WOLOG",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: LoginForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
