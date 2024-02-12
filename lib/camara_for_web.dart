import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:js' as js;

class CameraForWeb {
  @override
  Completer<dynamic> cameraForWeb(BuildContext context) {
    final Completer<dynamic> completer = Completer<dynamic>();
    js.context['captureImageCallback'] = (String base64String) {
      // Directly use the base64 string
      // Convert base64 string to Uint8List
      Uint8List imageBytes = base64Decode(base64String.split(',').last);

      print('Received image data with length: ${imageBytes.length}');
      completer.complete(
          imageBytes); // Adjust according to how you decide to handle the data
    };

    js.context.callMethod('captureImage', ['captureImageCallback']);
    return completer;
  }
}
