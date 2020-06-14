import 'package:fitsight_app/utils/global_exception_ui_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';
import 'package:fitsight_app/widgets/components/auth/login_form.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AppLoaded());
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.of(context).pushNamedAndRemoveUntil('/', (r) => false);
          }
          if (state is LoginFailureState) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    FlutterI18n.translate(
                        context, "auth.errors.login_failed.title"),
                  ),
                  content: Text(
                    FlutterI18n.translate(
                        context, "auth.errors.login_failed.content"),
                  ),
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
            Navigator.of(context).pop();
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
                      },
                    ),
                  ],
                );
              },
            );
          }
          if (state is SignUpFailureState) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(FlutterI18n.translate(
                      context, "sign_up.errors.email_already_exists.title")),
                  content: Text(FlutterI18n.translate(
                      context, "sign_up.errors.email_already_exists.content")),
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
          if (state is UnexpectedFailureState) {
            GlobalExceptionUIHandler.showUnexpectedErrorDialog(context);
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
