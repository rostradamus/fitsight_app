part of 'auth.dart';

Auth _$AuthFromJson(Map<String, dynamic> json) {
  return Auth(
    email: json['email'] as String,
    id: json['id'] as int,
    roles: List<String>.from(json['roles']),
    user: User.fromJson(json['user']),
  );
}

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'roles': instance.roles,
      'user': instance.user.toJson(),
    };
