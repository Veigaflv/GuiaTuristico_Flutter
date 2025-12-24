import 'package:flutter/material.dart';

class PraiasScreen extends StatelessWidget {
  const PraiasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Praias')),
      body: const Center(child: Text('Aqui estarão as praias')),
    );
  }
}
