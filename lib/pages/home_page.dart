import 'package:flutter/material.dart';
import 'dart:async';
import 'package:postsort_client/pages/summary_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:typed_data';

import '../camara_for_web_stub.dart'
    if (dart.library.html) '../camara_for_web.dart' as camera_for_web;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final Uint8List image = await pickImage(context);
                  if (image != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SummaryPage(image: image),
                      ),
                    );
                  }
                },
                child: Text("Capture Image"),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: Text('Login/SignUp'))
            ],
          ),
        ));
  }

  static Future<dynamic> pickImage(BuildContext context) async {
    if (kIsWeb) {
      final cameraForWebService = camera_for_web.CameraForWeb();
      final Completer<dynamic> completer =
          cameraForWebService.cameraForWeb(context);

      return completer.future;
    } else {
      // Mobile
      final ImagePicker picker = ImagePicker();
      XFile? file = await picker.pickImage(source: ImageSource.camera);
      return await file?.readAsBytes();
    }
  }
}
