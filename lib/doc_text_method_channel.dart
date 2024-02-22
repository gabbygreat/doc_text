import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'doc_text_platform_interface.dart';

/// An implementation of [DocTextPlatform] that uses method channels.
class MethodChannelDocText extends DocTextPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('doc_text');

  @override
  Future<String?> extractTextFromDoc(String filePath) async {
    // Pass the file path as a parameter to the native method
    final String? extractedText = await methodChannel.invokeMethod<String>(
      'extractTextFromDoc', // The name of the method
      {'filePath': filePath}, // Passing the file path as a method argument
    );
    return extractedText;
  }
}
