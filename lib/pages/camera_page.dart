import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postsort_client/pages/summary_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'dart:typed_data';

import '../camara_for_web_stub.dart'
    if (dart.library.html) '../camara_for_web.dart' as camera_for_web;

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() => CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  // CameraController? _controller;
  // Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // _initCamera();
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

  // Future<void> _initCamera() async {
  //   final cameras = await availableCameras();
  //   final firstCamera = cameras.first;

  //   _controller = CameraController(
  //     firstCamera,
  //     ResolutionPreset.medium,
  //   );

  //   _initializeControllerFuture = _controller?.initialize().then((_) {
  //     // Ensure the widget is still mounted before calling setState
  //     if (!mounted) return;
  //     // Trigger a rebuild once the camera is initialized
  //     setState(() {});
  //   }).catchError((Object e) {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           print('User denied camera access.');
  //           break;
  //         default:
  //           print('Unknown error occurred while initializing the camera: $e');
  //       }
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _controller?.dispose();
  //   super.dispose();
  // }

  // Future<void> _takePicture() async {
  //   if (_controller == null || !_controller!.value.isInitialized) {
  //     print('Error: select a camera first');
  //     return;
  //   }

  //   try {
  //     final image = await _controller!.takePicture();
  //     if (!mounted) return;
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => SummaryPage(imagePath: image.path)));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take Picture')),
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
                      builder: (context) => SummaryPage(),
                    ),
                  );
                }
              },
              child: Text("Capture Image"),
            )
          ],
        ),
      ),
    );
  }
}
