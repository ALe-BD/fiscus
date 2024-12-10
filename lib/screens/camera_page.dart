import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> cameras;
  CameraController? controller;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      // Retrieve available cameras
      cameras = await availableCameras();
      // Initialize the first camera (back camera)
      controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
      );
      await controller?.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> captureImage() async {
    if (!controller!.value.isInitialized) {
      return;
    }
    try {
      final image = await controller?.takePicture();
      if (image != null) {
        // Process the captured image (e.g., send it to an OCR library)
        print('Image saved to: ${image.path}');
        // Add receipt-reading logic here
      }
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
      ),
      body: isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(controller!),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: captureImage,
                      child: Text('Capture Receipt'),
                    ),
                  ),
                ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
