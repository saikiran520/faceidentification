import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'camera_screen.dart';
import 'login_response_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  /*Future<void> login(BuildContext context, List embedding) async {

    final body = {
      "currentEmbedding": embedding
    };

    print("LOGIN REQUEST: $body");

    final response = await http.post(
      Uri.parse("http://192.168.137.1:3000/api/customer/face-login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("LOGIN RESPONSE: ${response.body}");
  }*/

  Future<void> login(BuildContext context, List embedding) async {

    final body = {
      "currentEmbedding": embedding
    };

    print("LOGIN REQUEST: $body");

    final response = await http.post(
      Uri.parse("http://192.168.137.1:3000/api/customer/face-login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    print("LOGIN RESPONSE: ${response.body}");

    final Map data = jsonDecode(response.body);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginResponseScreen(response: data),
      ),
    );
  }

  openCamera(BuildContext context) async {

    final embedding = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CameraScreen(),
      ),
    );

    if (embedding != null) {
      await login(context, embedding);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Face Login")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => openCamera(context),
          child: const Text("Open Camera"),
        ),
      ),
    );
  }
}