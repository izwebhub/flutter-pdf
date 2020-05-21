import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:opening_a_pdf/pdf_page.dart';
import 'package:path_provider/path_provider.dart';

// Change this to fit the PDF file you are using to test.
const String _documentPath = 'PDFs/dummy.pdf';

class HomePage extends StatelessWidget {
  final BuildContext context;

  const HomePage(this.context);

  Future<String> prepareTestPdf() async {
    final ByteData bytes =
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$_documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);

    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              // We need to prepare the test PDF, and then we can display the PDF.
              var path = await prepareTestPdf();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PdfScreenPage(path)),
              );
            },
            child: const Text('Open PDF with full_pdf_viewer'),
          ),
        ],
      ),
    );
  }
}
