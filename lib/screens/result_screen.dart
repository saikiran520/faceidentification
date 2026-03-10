import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {

  final List embedding;

  const ResultScreen(this.embedding,{super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Embedding")),
      body: ListView.builder(
        itemCount: embedding.length,
        itemBuilder: (context,index){

          return ListTile(
            title: Text(
              "Index $index : ${embedding[index]}",
            ),
          );
        },
      ),
    );
  }
}