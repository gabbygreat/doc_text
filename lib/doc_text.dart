import 'doc_text_platform_interface.dart';

class DocText {
  Future<String?> extractTextFromDoc(String filePath) {
    return DocTextPlatform.instance.extractTextFromDoc(filePath);
  }
}
