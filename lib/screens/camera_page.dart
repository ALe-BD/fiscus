import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;
  String? _receiptInfo;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image using the camera
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _receiptInfo = null; // Reset receipt info
      });
    }
  }

  // Function to send the image to the backend
  Future<void> _sendImageToBackend() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final url = Uri.parse('http://192.168.87.228:8000/receipt/post');
      // Replace with your backend URL
      final request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', _image!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        // Decode the response as JSON
        final receiptData = json.decode(json.decode(responseData));
        print(receiptData);
        //Show a pop-up dialog with the receipt info
        _showReceiptDialog(receiptData);
      } else {
        setState(() {
          _receiptInfo = 'Failed to process receipt: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _receiptInfo = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showReceiptDialog(Map<String, dynamic> receiptData) {
    final TextEditingController categoryController =
        TextEditingController(text: receiptData['category']);
    final TextEditingController dateController =
        TextEditingController(text: receiptData['date']);
    final TextEditingController totalController =
        TextEditingController(text: receiptData['total'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Receipt Information'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(labelText: 'Date'),
                  ),
                  TextFormField(
                    controller: totalController,
                    decoration: InputDecoration(labelText: 'Total'),
                    keyboardType: TextInputType.number,
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Update the receipt data map with modified values
                receiptData['category'] = categoryController.text;
                receiptData['date'] = dateController.text;
                receiptData['total'] =
                    double.tryParse(totalController.text) ?? 0.0;

                // Close the dialog
                Navigator.of(context).pop();

                // Optionally update the state or perform further actions
                setState(() {
                  _receiptInfo = json.encode(receiptData);
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Instructions: Make sure the receipt is flat and on a dark surface. '
              'Position the receipt within the camera frame for best results. If the scanned receipt is incorrect please modify it.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          _image != null
              ? Image.file(
                  _image!,
                  height: 200,
                )
              : Icon(
                  Icons.camera_alt,
                  size: 100,
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Take a Photo'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _sendImageToBackend,
            child: Text('Process Receipt'),
          ),
          SizedBox(height: 20),
          _isLoading
              ? CircularProgressIndicator()
              : _receiptInfo != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Receipt Info: $_receiptInfo',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox.shrink(),
        ],
      ),
    );
  }
}
