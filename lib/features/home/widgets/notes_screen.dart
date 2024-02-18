import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:succeedemy/features/home/widgets/pdf_widget.dart';
import 'package:succeedemy/features/home/widgets/youtube_lecture.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class NotesScreen extends StatefulWidget {
  static const routeName = '/notes-screen';
  const NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> tags = ['JEE', 'NEET', 'Mains'];
  int page = 0;
  File? file;
  int? pages;
  void loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    file = await _storeFile(url, bytes);
    setState(() {
      file = file;
    });
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = path.basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }

  @override
  void initState() {
    super.initState();
    loadPdfFromNetwork(
        'https://drive.google.com/uc?export=download&id=1r7LLVlu0QTi3obuotM_VX31QUBr6gOGZ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (page == 1) {
                setState(() {
                  page = 0;
                });
              } else {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text('Lecture 1')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SwipeTo(
            iconOnLeftSwipe: Icons.view_module,
            animationDuration: const Duration(milliseconds: 100),
            // offsetDx: 3,
            onLeftSwipe: () {
              if (page == 0) {
                setState(() {
                  page = 1;
                });
              }
            },
            onRightSwipe: () {
              if (page == 1) {
                setState(() {
                  page = 0;
                });
              }
            },
            child: page == 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Topic: Kinematics',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'SubDetails: This is a description of the topic.',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: tags.map(
                          (e) {
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                      const SizedBox(height: 10),
                      const YoutubeLecture(),
                      const SizedBox(height: 10),
                      const Text(
                        'Handwritten Notes:',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      file == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : PDFWidget(
                              file: file!,
                            ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "MODULE",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      file == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : PDFWidget(
                              file: file!,
                            )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
