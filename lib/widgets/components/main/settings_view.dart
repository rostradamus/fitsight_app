import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitsight_app/blocs/auth/auth_bloc.dart';
import 'package:fitsight_app/blocs/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(8.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFDAE2F8), Color(0xFFD6A4A4)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                onTap: () => {},
                title: Text(
                  "Ro Lee",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://kansai-resilience-forum.jp/wp-content/uploads/2019/02/IAFOR-Blank-Avatar-Image-1.jpg',
                  ),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.lock_outline,
                    color: Colors.purple,
                  ),
                  title: Text("Change Password"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Colors.purple,
                  ),
                  title: Text("Change Language"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.report,
                    color: Colors.purple,
                  ),
                  title: Text("Report an Issue"),
                  onTap: () => {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.power_settings_new,
                    color: Colors.purple,
                  ),
                  title: Text("Logout"),
                  onTap: () =>
                      BlocProvider.of<AuthBloc>(context).add(LogoutSubmitted()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
