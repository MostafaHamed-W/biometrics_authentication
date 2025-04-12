import 'package:flutter/material.dart';

class HiddenContentScreen extends StatelessWidget {
  const HiddenContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hidden Content'),
      ),
      body: const Center(child: Text("Hidden Content Here!")),
    );
  }
}
