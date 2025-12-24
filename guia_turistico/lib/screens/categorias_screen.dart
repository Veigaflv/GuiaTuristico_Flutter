import 'package:flutter/material.dart';
import 'package:guia_turistico/screens/praias_screen.dart';
import 'package:guia_turistico/screens/monumentos_screen.dart';
import 'package:guia_turistico/screens/paisagens_screen.dart';

class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: Center( // <-- Centraliza o Column vertical e horizontalmente
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min, // <-- Faz o Column ocupar só o necessário
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PraiasScreen()),
                  );
                },
                child: const Text('Praias'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MonumentosScreen()),
                  );
                },
                child: const Text('Monumentos'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaisagensScreen()),
                  );
                },
                child: const Text('Paisagens'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

