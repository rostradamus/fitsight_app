import 'package:flutter/material.dart';
import 'package:wolog_app/widgets/components/login/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              child: LoginForm()
            )
          ],
        ),
      ),
    );
  }
}
