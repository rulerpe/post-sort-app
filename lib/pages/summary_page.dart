import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async'; // For StreamSubscription
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class SummaryPage extends StatefulWidget {
  final Uint8List image;

  SummaryPage({required this.image});

  @override
  SummaryPageState createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  StreamSubscription? _subscription;

  String? _shortSummary;
  String? _longSummary;
  String? _documentId;

  @override
  void initState() {
    super.initState();
    _uploadImageAndGetSummaries(widget.image);
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
          shortSummary
          longSummary
          shortSummaryZh
          longSummaryZh
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
          print('Received shortSummaryZh: ${event.data}');
          final jsonData = json.decode(event.data);
          setState(() {
            _shortSummary = jsonData["getNewDocument"]["shortSummaryZh"];
            _longSummary = jsonData["getNewDocument"]["longSummaryZh"];
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

  Future<void> _uploadImageAndGetSummaries(Uint8List image) async {
    try {
      // get presigned url
      final response = await http.get(Uri.parse(
          'https://0cex1llwp9.execute-api.us-west-1.amazonaws.com/presigned_s3_mailphoto_url'));
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
        appBar: AppBar(title: Text('Summary')),
        body: Center(
          child: _shortSummary == null || _longSummary == null
              ? CircularProgressIndicator() // Show loading indicator until summaries are fetched
              : Column(
                  children: [
                    Text('这是一封 $_shortSummary', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    Text('内容概要: $_longSummary', style: TextStyle(fontSize: 24)),
                    // Add a button to take another picture
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                      child: Text('Take Another Picture',
                          style: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
        ));
  }
}
