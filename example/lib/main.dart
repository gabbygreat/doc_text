import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:doc_text/doc_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? text;
  final _docTextPlugin = DocText();

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> extractTextFromDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['doc', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      try {
        text = await _docTextPlugin.extractTextFromDoc(file.path!) ??
            'Unknown platform version';
        if (!mounted) return;
        setState(() {});
      } on PlatformException {
        // Failed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.6,
              child: SingleChildScrollView(
                child: Text(
                  text ?? 'Select file',
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: extractTextFromDoc,
                    child: const Text('Open Doc file'),
                  ),
                  if (text != null)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        text = null;
                      }),
                      child: const Text('Close file'),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
