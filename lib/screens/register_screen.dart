import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'camera_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  List<double>? embedding;

  Future<void> register() async {

    if (embedding == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Capture face first")),
      );
      return;
    }

    final body = {
      "name": nameController.text,
      "phone": phoneController.text,
      "faceEmbedding": embedding
    };

    print("REGISTER REQUEST: $body");

    final response = await http.post(
      Uri.parse("http://192.168.137.1:3000/api/customer/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("REGISTER RESPONSE: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Success")),
      );
    }
  }

  openCamera() async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CameraScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        embedding = result;
      });

      print("Embedding received: ${embedding!.length}");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Register Face")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: openCamera,
              child: const Text("Capture Face"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: register,
              child: const Text("Register"),
            ),

          ],
        ),
      ),
    );
  }
}