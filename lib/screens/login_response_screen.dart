import 'package:flutter/material.dart';

class LoginResponseScreen extends StatelessWidget {

  final Map response;

  const LoginResponseScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {

    final bool success = response["success"] ?? false;
    final String message = response["message"] ?? "";

    return Scaffold(
      appBar: AppBar(title: const Text("Login Result")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              success ? "Login Successful" : "Login Failed",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Text("Message: $message"),

            const SizedBox(height: 20),

            Text("Full Response:"),

            const SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Text(response.toString()),
              ),
            ),

          ],
        ),
      ),
    );
  }
}