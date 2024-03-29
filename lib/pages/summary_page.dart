import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async'; // For StreamSubscription
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import '../summary_page_arg_providar.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

class SummaryPageArguments {
  final Uint8List image;

  SummaryPageArguments(this.image);
}

class SummaryPage extends StatefulWidget {
  SummaryPage();

  @override
  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  StreamSubscription? _subscription;

  String? _title;
  String? _summary;
  String? _action;
  String? _documentId;
  bool _isImageProcessed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isImageProcessed) {
      final argsProvider = Provider.of<SummaryPageArgumentsProvider>(context);
      final Uint8List? image = argsProvider.args?.image;
      if (image != null) {
        _uploadImageAndGetSummaries(image);
        _isImageProcessed = true;
      }
    }
    ;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _subscribeToDocumentUpdates(String documentId) {
    print('documentId: $documentId');
    const String subscriptionString = '''
      subscription GetNewDocument(\$documentId: ID!) {
        getNewDocument(documentId: \$documentId) {
          documentId
          originalText
          title
          summary
          action
          titleTranslated
          summaryTranslated
          actionTranslated
        }
      }
    ''';

    final GraphQLRequest<dynamic> request = GraphQLRequest<String>(
      document: subscriptionString,
      variables: {
        'documentId': documentId,
      },
    );

    _subscription = Amplify.API.subscribe(request).listen(
      (event) {
        if (event.data != null) {
          print('Received event.data: ${event.data}');
          final jsonData = json.decode(event.data);
          setState(() {
            _title = jsonData["getNewDocument"]["titleTranslated"];
            _summary = jsonData["getNewDocument"]["summaryTranslated"];
            _action = jsonData["getNewDocument"]["actionTranslated"];
          });
          _subscription?.cancel();
        } else {
          print('no event data');
        }
      },
      onError: (Object e) => print('Subscription error: $e'),
    );
  }

  String _extractDocumentId(String objectKey) {
    var parts = objectKey.split('/');
    var filenameWithExtension = parts.last;
    var documentId = filenameWithExtension.split('.').first;
    return documentId;
  }

  // create unqiu id for each device, to track usage, before user authancation in implmented
  Future<String> getOrCreateUniqueId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uniqueId = prefs.getString('unique_id');
    if (uniqueId == null) {
      uniqueId = Uuid().v4(); // Generates a new UUID
      await prefs.setString('unique_id', uniqueId);
    }
    return uniqueId;
  }

  Future<void> _uploadImageAndGetSummaries(Uint8List image) async {
    try {
      // get presigned url
      var uniqueId = await getOrCreateUniqueId();
      var url = Uri.parse(
              'https://0cex1llwp9.execute-api.us-west-1.amazonaws.com/presigned_s3_mailphoto_url')
          .replace(queryParameters: {'uniqueId': uniqueId});
      final response = await http.get(url);
      print('response from geting url: $response');
      if (response.statusCode != 200) {
        print('Failed to fetch presigned URL: ${response.body}');
        return; // Early return on failure
      }
      final responseData = json.decode(response.body);
      final String presignedUrl = responseData['url'];
      final String documentId = _extractDocumentId(responseData['key']);
      setState(() {
        _documentId = documentId;
      });
      print("presigned url: ${presignedUrl}");

      _subscribeToDocumentUpdates(documentId);

      // upload image with the presinged url
      // final imageBytes = await _readImageBytes(image);
      final uploadResponse = await http.put(
        Uri.parse(presignedUrl),
        body: image,
        headers: {
          "Content-Type": "image/jpeg"
        }, // Adjust based on your image type
      );
      if (uploadResponse.statusCode != 200) {
        print('Image upload failed: ${uploadResponse.body}');
        return; // Early return on failure
      }
    } catch (error) {
      print('Error fetching presigned URL or uploading image: $error');
    }
  }

  Future<List<int>> _readImageBytes(XFile image) async {
    print('_readImageBytes');
    // File imageFile = File(imagePath);
    List<int> imageBytes = await image.readAsBytes();
    return imageBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('读信')),
      body: Center(
          child: _title == null || _summary == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('正在读信...', style: TextStyle(fontSize: 24))
                  ],
                ) // Show loading indicator until summaries are fetched
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('标题: $_title', style: TextStyle(fontSize: 24)),
                        SizedBox(height: 10),
                        Text('内容概要: $_summary', style: TextStyle(fontSize: 24)),
                        SizedBox(height: 10),
                        Text('$_action', style: TextStyle(fontSize: 24)),
                      ],
                    ),
                  ),
                )),
      bottomNavigationBar: _title != null && _summary != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(double.infinity, 50), // make button wider and taller
                ),
                child: Text('下一封信', style: TextStyle(fontSize: 24)),
              ),
            )
          : null,
    );
  }
}
