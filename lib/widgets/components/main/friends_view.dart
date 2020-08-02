import 'package:fitsight_app/blocs/friends/friends_bloc.dart';
import 'package:fitsight_app/blocs/friends/friends_event.dart';
import 'package:fitsight_app/blocs/friends/friends_state.dart';
import 'package:fitsight_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FriendsBloc>(context).add(FriendsViewLoaded());
    return Container(
      child: Stack(
        children: <Widget>[
          BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              if (state is FriendsLoadedState) {
                return ListView(
                  children: state.friends
                      .map(
                        (User user) => ListTile(
                          onTap: () {
                            print("Pressed: ${user.email}");
                          },
                          onLongPress: () {
                            print("Pressed: ${user.fullName}");
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.green,
                          ),
                          title: Text(user.fullName),
                          subtitle: Text(user.email),
                        ),
                      )
                      .toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            },
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
                      onPressed: () => BlocProvider.of<FriendsBloc>(context)
                          .add(FriendsListRefreshed()),
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
                            "Refresh",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
