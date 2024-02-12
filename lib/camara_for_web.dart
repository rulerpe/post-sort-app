import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:postsort_client/pages/summary_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:js' as js;
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

      // Here you need to handle the data as per your requirement
      // Since XFile expects a path, which we don't have in web,
      // you might need to use another method to handle this image data.
      // For example, you could save this data in memory and use it directly
      // or upload it to a server as is.

      // For demonstration, let's just log the length of the bytes to confirm
      print('Received image data with length: ${imageBytes.length}');
      completer.complete(
          imageBytes); // Adjust according to how you decide to handle the data
    };

    js.context.callMethod('captureImage', ['captureImageCallback']);
    return completer;
  }
}
