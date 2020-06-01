import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wolog_app/widgets/pages/home_page.dart';
import 'package:wolog_app/widgets/pages/login_page.dart';

import 'blocs/auth/auth_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/': (context) => HomePage(),
          '/login': (context) => LoginPage()
        },
      ),
    );
  }
}
