import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';
import 'package:fitsight_app/utils/i18n.dart';
import 'package:fitsight_app/widgets/components/auth/login_form.dart';
import 'package:fitsight_app/widgets/components/auth/sign_up_form.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LoginPageLoadedEvent());
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
          }
          if (state is LoginFailureState) {
            var contentText = (state.statusCode == HttpStatus.unauthorized)
                ? I18n.UNAUTHENTICATED
                : I18n.UNEXPECTED;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(I18n.TRY_AGAIN),
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
                  title: Text(I18n.THANK_YOU),
                  content: Text(I18n.SIGN_UP_SUCCESS),
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
            var contentText =
                (state.statusCode == HttpStatus.unprocessableEntity)
                    ? I18n.EMAIL_ALREADY_EXISTS
                    : I18n.UNEXPECTED;
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(I18n.TRY_AGAIN),
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
