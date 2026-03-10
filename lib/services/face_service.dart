import 'dart:io';
import 'dart:typed_data';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class FaceService {
  static FaceDetector? _faceDetector;
  static Interpreter? _interpreter;

  static Future<void> _initialize() async {
    if (_faceDetector == null) {
      _faceDetector = FaceDetector(
        options: FaceDetectorOptions(
          performanceMode: FaceDetectorMode.accurate,
          enableLandmarks: false,
          enableClassification: false,
        ),
      );
    }
    if (_interpreter == null) {
      try {
        _interpreter = await Interpreter.fromAsset('assets/mobilefacenet.tflite');
        print('[FaceService] Interpreter loaded successfully');
      } catch (e) {
        print('[FaceService] Error loading interpreter: $e');
      }
    }
  }

  static Future<List<double>> analyze(String imagePath) async {
    await _initialize();

    if (_faceDetector == null || _interpreter == null) {
      print('[FaceService] ERROR: Services NOT initialized');
      return [];
    }

    try {
      print('[FaceService] Stage 1: Processing Image...');
      final File imageFile = File(imagePath);
      final Uint8List bytes = await imageFile.readAsBytes();
      
      img.Image? originalImage = img.decodeImage(bytes);
      if (originalImage == null) return [];

      // Normalize orientation
      img.Image normalizedImage = img.bakeOrientation(originalImage);
      
      // Save temp for ML Kit
      final tempDir = await Directory.systemTemp.createTemp();
      final normalizedPath = '${tempDir.path}/temp_face.jpg';
      await File(normalizedPath).writeAsBytes(img.encodeJpg(normalizedImage));

      print('[FaceService] Stage 2: Detecting Face...');
      final inputImage = InputImage.fromFilePath(normalizedPath);
      List<Face> faces = await _faceDetector!.processImage(inputImage);
      
      // Cleanup temp
      try { await File(normalizedPath).delete(); await tempDir.delete(recursive: true); } catch (_) {}

      if (faces.isEmpty) {
        print('[FaceService] No faces detected.');
        return [];
      }

      print('[FaceService] Found ${faces.length} face(s). Stage 3: Inference...');
      final face = faces.first;
      final rect = face.boundingBox;
      
      // Crop
      int left = rect.left.toInt().clamp(0, normalizedImage.width);
      int top = rect.top.toInt().clamp(0, normalizedImage.height);
      int width = rect.width.toInt().clamp(1, normalizedImage.width - left);
      int height = rect.height.toInt().clamp(1, normalizedImage.height - top);

      img.Image faceImage = img.copyCrop(
        normalizedImage,
        x: left,
        y: top,
        width: width,
        height: height,
      );

      // Resize to 112x112
      img.Image resizedFace = img.copyResize(faceImage, width: 112, height: 112);

      // Convert image to 4D List [1, 112, 112, 3] for TFLite
      var input = List.generate(
        1,
        (i) => List.generate(
          112,
          (j) => List.generate(
            112,
            (k) => List.generate(3, (l) => 0.0),
          ),
        ),
      );

      for (var y = 0; y < 112; y++) {
        for (var x = 0; x < 112; x++) {
          var pixel = resizedFace.getPixel(x, y);
          // Normalize to [-1, 1] or [0, 1] as expected by MobileFaceNet
          // Typically MobileFaceNet expects (x - 127.5) / 128 or (x - 127.5) / 127.5
          input[0][y][x][0] = (pixel.r - 127.5) / 127.5;
          input[0][y][x][1] = (pixel.g - 127.5) / 127.5;
          input[0][y][x][2] = (pixel.b - 127.5) / 127.5;
        }
      }

      // Output shape handle
      var outputShape = _interpreter!.getOutputTensors()[0].shape;
      var outputSize = outputShape.reduce((a, b) => a * b);
      var output = List<double>.filled(outputSize, 0).reshape(outputShape);

      // RUN INFERENCE
      _interpreter!.run(input, output);

      // Flatten result
      List<double> embedding = [];
      if (output is List<List<double>>) {
        embedding = List<double>.from(output[0]);
      } else if (output is List<double>) {
        embedding = List<double>.from(output);
      } else {
        embedding = (output as List).expand((e) => e is List ? e : [e]).cast<double>().toList();
      }

      print('[FaceService] SUCCESS: Embedding captured!');
      return embedding;

    } catch (e) {
      print('[FaceService] CRITICAL ERROR: $e');
      return [];
    }
  }

  static void dispose() {
    _faceDetector?.close();
    _interpreter?.close();
    _faceDetector = null;
    _interpreter = null;
  }
}