import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'doc_text_method_channel.dart';

abstract class DocTextPlatform extends PlatformInterface {
  /// Constructs a DocTextPlatform.
  DocTextPlatform() : super(token: _token);

  static final Object _token = Object();

  static DocTextPlatform _instance = MethodChannelDocText();

  /// The default instance of [DocTextPlatform] to use.
  ///
  /// Defaults to [MethodChannelDocText].
  static DocTextPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DocTextPlatform] when
  /// they register themselves.
  static set instance(DocTextPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> extractTextFromDoc(String filePath) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
