
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:succeedemy/utils/show_snack_bar.dart';

void httpErrorHandle({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(res.body)['message']);
      break;
    case 500:
      showSnackBar(context, res.body);
      break;
  }
}