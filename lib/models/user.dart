part 'user.g.dart';

class User {
  int id;
  String email;
  String firstName;
  String lastName;

  User({this.id, this.email, this.firstName, this.lastName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
