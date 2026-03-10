import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../services/face_service.dart';
import 'result_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  CameraController? controller;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  initCamera() async {
    final cameras = await availableCameras();
    
    // Select front camera if available
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller!.initialize();

    if (!mounted) return;
    setState(() {});
  }

  capture() async {
    if (controller == null || !controller!.value.isInitialized) return;

    final image = await controller!.takePicture();

    final embedding = await FaceService.analyze(image.path);
    if (embedding.isNotEmpty) {
      print("===== FACE EMBEDDING GENERATED =====");
      print("Length: ${embedding.length}");

      for (int i = 0; i < embedding.length; i++) {
        print("[$i] : ${embedding[i]}");
      }

      print("===== END EMBEDDING =====");
    }

    if (!mounted) return;

    if (embedding.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No face detected! Please try again.")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(embedding),
      ),
    );
  }

  @override
  void dispose() {
    FaceService.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (controller == null ||
        !controller!.value.isInitialized) {

      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [

          CameraPreview(controller!),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: capture,
                child: const Icon(Icons.camera),
              ),
            ),
          )

        ],
      ),
    );
  }
}