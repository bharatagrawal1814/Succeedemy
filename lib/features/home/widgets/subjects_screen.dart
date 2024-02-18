// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:succeedemy/features/home/services/home_service.dart';
import 'package:succeedemy/features/home/widgets/notes_screen.dart';
import 'package:succeedemy/model/notes.dart';

class SubjectScreen extends StatefulWidget {
  static const routeName = '/subject-screen';
  final String subject;
  final String studentClass;
  const SubjectScreen({
    Key? key,
    required this.subject,
    required this.studentClass,
  }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final HomeService homeService = HomeService();
  List<Notes> notes = [];
  Set<String> chapters = {};
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    notes = await homeService.fetchNotes(
        context: context,
        studentClass: widget.studentClass,
        subject: widget.subject);
    for (int i = 0; i < notes.length; i++) {
      chapters.add(notes[i].chapter);
    }
    setState(() {
      chapters = chapters;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: chapters
                .map(
                  (e) => ExpansionTile(
                      title: Text(e),
                      leading: const Icon(Icons.science),
                      shape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white)),
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white)),
                          1),
                      collapsedShape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white)),
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: Colors.white)),
                          1),
                      children: notes
                          .where((element) => element.chapter == e)
                          .map((e) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, NotesScreen.routeName);
                                },
                                child: ListTile(
                                  title: Text(e.lecture),
                                  visualDensity: VisualDensity.comfortable,
                                  tileColor: Colors.grey[100],
                                  leading: const Icon(Icons.book),
                                ),
                              ))
                          .toList()),
                )
                .toList(),
          )),
    );
  }
}
