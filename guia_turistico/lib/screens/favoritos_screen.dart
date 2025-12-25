import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'detalhes_screen.dart';
import '../services/favoritos_service.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  List<Map<String, dynamic>> favoritos = [];

  @override
  void initState() {
    super.initState();
    loadFavoritos(); // chama ao iniciar
  }

  Future<void> loadFavoritos() async {
    final ids = await FavoritosService.getFavoritosIds();
    final String jsonString =
        await rootBundle.loadString('data/pointsOfInterest.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    final List<Map<String, dynamic>> favoritosFiltrados = jsonData
        .where((item) => ids.contains(item['id']))
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    setState(() {
      favoritos = favoritosFiltrados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: favoritos.isEmpty
          ? const Center(
              child: Text('Sem favoritos ainda'),
            )
          : ListView.builder(
              itemCount: favoritos.length,
              itemBuilder: (context, index) {
                final item = favoritos[index];
                return ListTile(
                  leading: Image.asset(item['image'], width: 50, fit: BoxFit.cover),
                  title: Text(item['name']),
                  subtitle: Text(item['short_description']),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetalhesScreen(item: item),
                      ),
                    );
                    // Atualiza a lista ao voltar dos detalhes
                    loadFavoritos();
                  },
                );
              },
            ),
    );
  }
}

