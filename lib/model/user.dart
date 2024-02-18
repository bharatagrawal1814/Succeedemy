// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String password;
  final String studentClass;
  final DateTime dob;
  final String type;
  final String token;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.studentClass,
    required this.dob,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'studentClass': studentClass,
      'dob': dob.toString(),
      'type': type,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      password: map['password'] as String,
      studentClass: map['studentClass'] as String,
      dob: DateTime.parse(map['dob'].toString().split('T')[0]),
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
