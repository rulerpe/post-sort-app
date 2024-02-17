import 'package:flutter/material.dart';
import 'dart:async';
import 'package:DuXin/pages/summary_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:typed_data';

import '../camara_for_web_stub.dart'
    if (dart.library.html) '../camara_for_web.dart' as camera_for_web;
import 'package:provider/provider.dart';
import '../summary_page_arg_providar.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomePage extends StatelessWidget {
  final FirebaseAnalytics analytics;
  HomePage({required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('读信')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  analytics.logEvent(
                    name: 'capture_photo_clicked',
                  );
                  final provider = Provider.of<SummaryPageArgumentsProvider>(
                      context,
                      listen: false);
                  final Uint8List image = await pickImage(context);
                  if (image != null) {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => SummaryPage(image: image),
                    //   ),
                    // );
                    provider.setArgs(SummaryPageArguments(image));
                    Navigator.pushNamed(
                      context,
                      '/summary',
                    );
                  }
                },
                child: Text("拍摄信件", style: TextStyle(fontSize: 24)),
              ),
              // ElevatedButton(
              //     onPressed: () => Navigator.pushNamed(context, '/login'),
              //     child: Text('Login/SignUp'))
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
      XFile? file = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      return await file?.readAsBytes();
    }
  }
}
