import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:doc_text/doc_text_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDocText platform = MethodChannelDocText();
  const MethodChannel channel = MethodChannel('doc_text');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('extractTextFromDoc', () async {
    // Adjust this to match the actual argument you expect in your method call.
    const String filePath = 'valid/path/to/document.doc';
    expect(
        await platform.extractTextFromDoc(filePath), 'Expected extracted text');
  });
}
