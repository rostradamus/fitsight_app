import 'dart:collection';

class User {
  String _email;
  Set<String> _roles;

  String get email => _email;
  UnmodifiableListView<String> get roles => UnmodifiableListView(_roles);

  User(this._email, this._roles);

  void addRole(String role) {
    roles.add(role);
  }
}
