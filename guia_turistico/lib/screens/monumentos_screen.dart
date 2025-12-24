import 'package:flutter/material.dart';

class MonumentosScreen extends StatelessWidget {
  const MonumentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monumentos')),
      body: const Center(child: Text('Aqui estarão os monumentos')),
    );
  }
}