import 'package:fitsight_app/blocs/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:fitsight_app/blocs/bottom_navigation/bottom_navigation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) => BlocProvider.of<BottomNavigationBloc>(context)
          .add(PageTapped(index: index)),
      currentIndex: BlocProvider.of<BottomNavigationBloc>(context).currentIndex,
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
          icon: Icon(Icons.calendar_today),
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
    );
  }
}
