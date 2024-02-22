package com.gabbygreat.doc_text

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import org.apache.poi.hwpf.HWPFDocument
import org.apache.poi.hwpf.extractor.WordExtractor
import org.apache.poi.xwpf.extractor.XWPFWordExtractor
import org.apache.poi.xwpf.usermodel.XWPFDocument
import java.io.File
import java.io.FileInputStream



/** DocTextPlugin */
class DocTextPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "doc_text")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
     if (call.method == "extractTextFromDoc") {
        val filePath = call.argument<String>("filePath")
        val text = filePath?.let { extractTextFromDoc(it) }
        if (text != null) {
            result.success(text)
        } else {
            result.error("UNAVAILABLE", "Could not extract text.", null)
        }
    } else {
      result.notImplemented()
    }
  }

   private fun extractTextFromDoc(filePath: String): String? {
      val file = File(filePath)
      val input = FileInputStream(file)
      return try {
           return if (filePath.endsWith(".doc")) {
                    // Handling .doc files (binary format)
                    val document = HWPFDocument(input)
                    val extractor = WordExtractor(document)
                    val text = extractor.text
                    extractor.close()
                    text
                } else if (filePath.endsWith(".docx")) {
                    // Handling .docx files (OOXML format)
                    val document = XWPFDocument(input)
                    val extractor = XWPFWordExtractor(document)
                    val text = extractor.text
                    extractor.close()
                    text
                } else {
                    throw IllegalArgumentException("Unsupported file format")
                }
      } catch (e: Exception) {
          e.printStackTrace()
          null
      }
    }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
