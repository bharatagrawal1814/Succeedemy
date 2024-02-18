// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:succeedemy/model/user.dart';
import 'package:succeedemy/provider/user_provider.dart';
import 'package:succeedemy/utils/bottom_bar.dart';
import 'package:succeedemy/utils/error_handling.dart';
import 'package:succeedemy/utils/global_variables.dart';
import 'package:succeedemy/utils/show_snack_bar.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signupUser(
      {required BuildContext context,
      required String name,
      required String mobile,
      required String email,
      required DateTime dob,
      required String studentClass,
      required String password}) async {
    try {
      User user = User(
          email: email,
          mobile: mobile,
          name: name,
          password: password,
          studentClass: studentClass,
          dob: dob,
          type: 'student',
          id: '',
          token: '');
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () {
            signinUser(context: context, email: email, password: password);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //signin user
  void signinUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () async {
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //get user data
  Future<void> getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      } else {
        var tokenRes = await http.post(
          Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          http.Response userRes = await http.get(
            Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            },
          );

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
