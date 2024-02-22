import 'package:flutter_test/flutter_test.dart';
import 'package:doc_text/doc_text.dart';
import 'package:doc_text/doc_text_platform_interface.dart';
import 'package:doc_text/doc_text_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDocTextPlatform
    with MockPlatformInterfaceMixin
    implements DocTextPlatform {
  @override
  Future<String?> extractTextFromDoc(String filePath) async {
    // Simulate extracting text from a DOC file specified by filePath.
    // This is where you return what you expect for a given test filePath.
    if (filePath == 'valid/path/to/document.doc') {
      return 'Expected extracted text';
    }
    return 'Unexpected file path';
  }
}

void main() {
  final DocTextPlatform initialPlatform = DocTextPlatform.instance;

  test('$MethodChannelDocText is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDocText>());
  });

  test('extractTextFromDoc', () async {
    DocText docTextPlugin = DocText();
    MockDocTextPlatform fakePlatform = MockDocTextPlatform();
    DocTextPlatform.instance = fakePlatform;

    // Assuming 'valid/path/to/document.doc' is a path you want to test
    const filePath = 'valid/path/to/document.doc';
    final extractedText = await docTextPlugin.extractTextFromDoc(filePath);

    expect(extractedText, 'Expected extracted text');
  });
}
