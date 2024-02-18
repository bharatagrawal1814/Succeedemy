import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:succeedemy/model/notes.dart';
import 'package:succeedemy/utils/error_handling.dart';
import 'package:succeedemy/utils/global_variables.dart';
import 'package:succeedemy/utils/show_snack_bar.dart';

class HomeService {
  //fetch notes
  Future<List<Notes>> fetchNotes(
      {required BuildContext context,
      required String studentClass,
      required String subject}) async {
    List<Notes> notes = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/notes/$studentClass/$subject'));
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          context: context,
          res: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              notes.add(Notes.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return notes;
  }
}
