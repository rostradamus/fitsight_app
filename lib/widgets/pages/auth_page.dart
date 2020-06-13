import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';
import 'package:fitsight_app/widgets/components/auth/login_form.dart';
import 'package:fitsight_app/widgets/components/auth/sign_up_form.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LoginPageLoadedEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          }
          if (state is LoginFailureState) {
            var titleText = (state.statusCode == HttpStatus.unauthorized)
                ? FlutterI18n.translate(
                    context, "auth.errors.login_failed.title")
                : FlutterI18n.translate(
                    context, "http.errors.internal_server_error.title");
            var contentText = (state.statusCode == HttpStatus.unauthorized)
                ? FlutterI18n.translate(
                    context, "auth.errors.login_failed.content")
                : FlutterI18n.translate(
                    context, "http.errors.internal_server_error.content");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(titleText),
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
          if (state is SignUpSuccessState) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    FlutterI18n.translate(
                      context,
                      "sign_up.success.title",
                    ),
                  ),
                  content: Text(
                    FlutterI18n.translate(
                      context,
                      "sign_up.success.content",
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<AuthBloc>(context)
                            .add(LoginPageLoadedEvent());
                      },
                    ),
                  ],
                );
              },
            );
          }
          if (state is SignUpFailureState) {
            var titleText = (state.statusCode == HttpStatus.unprocessableEntity)
                ? FlutterI18n.translate(
                    context, "sign_up.errors.email_already_exists.title")
                : FlutterI18n.translate(
                    context, "http.errors.internal_server_error.title");
            var contentText =
                (state.statusCode == HttpStatus.unprocessableEntity)
                    ? FlutterI18n.translate(
                        context, "sign_up.errors.email_already_exists.content")
                    : FlutterI18n.translate(
                        context, "http.errors.internal_server_error.content");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(titleText),
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
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthInitialState || state is AuthRequestState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is SignUpWaitingState ||
                  state is SignUpSuccessState ||
                  state is SignUpFailureState) {
                return Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                              ),
                              padding: EdgeInsets.all(0.0),
                              color: Colors.transparent,
                              onPressed: () =>
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(SignUpBackButtonPressedEvent()),
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                size: 40,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: SignUpForm(),
                    ),
                  ],
                );
              }
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(100.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Text(
                          "FitSight",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
