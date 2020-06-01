import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolog_app/blocs/auth/auth_bloc.dart';
import 'package:wolog_app/login_form.dart';
import 'package:wolog_app/service_locator.dart';

void main() {
  setupLocators();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: false ? AppBar(
        title: Text('Flutter layout demo'),
      ) : null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage('assets/images/background.png'),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(100.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Text(
                    "TITLE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    )
                  )
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: LoginForm()
              )
            )
          ],
        ),
      ),
    );
  }
}
