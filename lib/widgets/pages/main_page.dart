import 'package:fitsight_app/widgets/components/main/friends_view.dart';
import 'package:fitsight_app/widgets/components/main/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:fitsight_app/blocs/auth/auth_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_state.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    FriendsView(),
  ];

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
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
