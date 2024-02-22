# doc_text

A Flutter plugin for extracting the content of a Word document (`.doc` or `.docx`) as a plain text string. This plugin supports reading text from Word documents on both Android and iOS platforms, making it easier to integrate document handling into your Flutter applications.

## Description

The `doc_text` plugin provides a straightforward method to extract text from Word documents. This can be particularly useful for applications that need to read, display, or process the content of document files without requiring external applications.

## Setup

### Android

To use this plugin on Android, you need to ensure that your project's `minSdkVersion` is set to 26 or higher due to the dependencies used for reading Word documents.

Open your Android project's `build.gradle` file located in `your_project/android/app/build.gradle` and update the `minSdkVersion` to 26:

```groovy
android {
    ...

    defaultConfig {
        ...
        minSdkVersion 26
        ...
    }
}
```

### iOS

Due to limitations in iOS's native support for .doc and .docx formats, this plugin currently offers limited functionality on iOS platforms. Please consider using alternative methods for document handling on iOS.

## Adding the Plugin

Add doc_text to your pubspec.yaml file:

```yaml
dependencies:
  doc_text: ^0.0.1
```

```dart
import 'package:doc_text/doc_text.dart';


void main() async {
  final String filePath = 'path/to/your/document.docx';
  final String? extractedText = await DocText.extractTextFromDoc(filePath);

  if (extractedText != null) {
    print(extractedText);
  } else {
    print('Failed to extract text from document.');
  }
}
```

### Contributing

We welcome contributions to the doc_text plugin! If you'd like to contribute, please fork the repository and submit pull requests. For major changes or new features, please open an issue first to discuss what you would like to add or change.

### License

[doc_text](https://github.com/gabbygreat/doc_text) is available under the MIT license. See the [LICENSE](https://github.com/gabbygreat/doc_text/blob/master/LICENSE) file for more info.
