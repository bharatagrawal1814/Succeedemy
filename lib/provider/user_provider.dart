import 'package:flutter/material.dart';
import 'package:succeedemy/model/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    mobile: '',
    studentClass: '',
    dob: DateTime(2000),
    password: '',
    token: '',
    type: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
