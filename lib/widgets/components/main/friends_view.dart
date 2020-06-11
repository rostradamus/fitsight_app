import 'package:fitsight_app/models/user.dart';
import 'package:fitsight_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// TODO: (Temporary) Needs to be re-implemented
class FriendsView extends StatefulWidget {
  @override
  _FriendsViewState createState() => _FriendsViewState();
}

class _FriendsViewState extends State<FriendsView> {
  ApiService apiService = GetIt.I.get<ApiService>();
  List<User> users = [];

  void fetchUsers() async {
    var response = await apiService.getClient().get('/users');
    List<User> fetchedUsers = List<User>.from(
        List<Map>.from(response.data).map((Map model) => User.fromJson(model)));
    setState(() {
      users = fetchedUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView(
            children: users
                .map((User user) => ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                      title: Text(user.email),
                    ))
                .toList(),
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
                      onPressed: fetchUsers,
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
