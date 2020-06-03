import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolog_app/blocs/auth/auth_bloc.dart';
import 'package:wolog_app/blocs/auth/auth_event.dart';
import 'package:wolog_app/blocs/auth/auth_state.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String message = 'User is Not Logged In !';
            if (state is LoginSuccessState) {
              message = 'User is Logged In !';
            }
            return Text(message);
          },
        ),
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(100.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is LoginSuccessState)
                        return Text("Hello ${state.user.email}!",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic));
                      return Text("Hello !",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic));
                    },
                    listener: (context, state) {
                      if (state is LogoutSuccessState) {
                        Navigator.of(context).pushNamed('/login');
                      }
                    },
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: RaisedButton(
                      onPressed: () async {
                        BlocProvider.of<AuthBloc>(context)
                            .add(LogoutSubmittedEvent());
                        // Navigator.pushNamed(context, '/login');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFDAE2F8),
                                Color(0xFFD6A4A4)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      )),
    );
  }
}
