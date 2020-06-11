import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:fitsight_app/widgets/pages/main_page.dart';
import 'package:fitsight_app/widgets/pages/auth_page.dart';
import 'package:fitsight_app/widgets/pages/sign_up_page.dart';

import 'blocs/auth/auth_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/login',
              routes: {
                '/': (context) => MainPage(),
                '/login': (context) => AuthPage(),
                '/signup': (context) => SignUpPage(),
              },
            ),
          );
        }
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.red],
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
