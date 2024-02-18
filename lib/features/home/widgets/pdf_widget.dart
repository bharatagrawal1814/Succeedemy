import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFWidget extends StatelessWidget {
  final File file;
  const PDFWidget({Key? key, required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // fit: FlexFit.loose,
      child: PDFView(
        filePath: file.path,
        autoSpacing: false,
        pageFling: false,
        pageSnap: false,
      ),
    );
  }
}
