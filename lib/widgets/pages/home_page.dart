import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:fitsight_app/blocs/auth/auth_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';
import 'package:fitsight_app/models/user.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue, Colors.red],
        ),
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String message = 'User is Not Logged In !';
            if (state is LoginSuccessState) {
              message = "Good Morning, ${state.auth.user.firstName} !";
            }
            return Text(
              message,
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is LoginSuccessState) {
                        User user = state.auth.user;
                        return Text(
                            "Hello,\n${user.firstName} ${user.lastName}!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic));
                      }
                      return Text("Hello !",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic));
                    },
                    listener: (context, state) {
                      if (state is LogoutRequestState) {
                        Navigator.of(context).pushNamed('/login');
                      }
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 50,
                      width: 70,
                      child: RaisedButton(
                        onPressed: () async {
                          BlocProvider.of<AuthBloc>(context)
                              .add(LogoutSubmittedEvent());
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
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
                            constraints: BoxConstraints(
                              maxWidth: 300.0,
                              minHeight: 50.0,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Logout",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Friends"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Me"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            title: Text("Plan"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
