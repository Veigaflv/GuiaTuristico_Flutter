import 'package:flutter/material.dart';

class PaisagensScreen extends StatelessWidget {
  const PaisagensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paisagens')),
      body: const Center(child: Text('Aqui estarão as paisagens')),
    );
  }
}