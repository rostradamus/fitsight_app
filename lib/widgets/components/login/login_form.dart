import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:wolog_app/blocs/auth/auth_bloc.dart';
import 'package:wolog_app/blocs/auth/auth_event.dart';
import 'package:wolog_app/blocs/auth/auth_state.dart';
import 'package:wolog_app/services/api_service.dart';

class LoginForm extends StatelessWidget {
  ApiService get apiService => GetIt.I.get<ApiService>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.60),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]))),
                    child: TextField(
                      key: ValueKey("text"),
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Email address"),
                    ))
              ],
            )),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.60),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[100]))),
                    child: TextField(
                      key: ValueKey("text"),
                      controller: _passwordController,
                      textInputAction: TextInputAction.send,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Password"),
                    ))
              ],
            )),
        SizedBox(height: 10),
        Container(
          height: 50.0,
          child: RaisedButton(
            onPressed: () async {
              BlocProvider.of<AuthBloc>(context).add(LoginSubmittedEvent(
                  email: _emailController.text,
                  password: _passwordController.text));
              _emailController.clear();
              _passwordController.clear();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFFDAE2F8), Color(0xFFD6A4A4)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
