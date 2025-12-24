import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class MonumentosScreen extends StatefulWidget {
  const MonumentosScreen({super.key});

  @override
  State<MonumentosScreen> createState() => _MonumentosScreenState();
}

class _MonumentosScreenState extends State<MonumentosScreen> {
  List<Map<String, dynamic>> monumentos = [];

  @override
  void initState() {
    super.initState();
    loadMonumentos();
  }

  Future<void> loadMonumentos() async {
    final String jsonString = await rootBundle.loadString('data/pointsOfInterest.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Filtra apenas os itens do tipo "Monumento"
    final List<Map<String, dynamic>> monumentosFiltrados = jsonData
        .where((item) => item['tipo'] == 'Monumento')
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    setState(() {
      monumentos = monumentosFiltrados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Monumentos')),
      body: monumentos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: monumentos.length,
              itemBuilder: (context, index) {
                final monumento = monumentos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      monumento['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(monumento['name']),
                    subtitle: Text(monumento['short_description']),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(monumento['name']),
                          content: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Imagem do lado esquerdo
                                SizedBox(
                                  width: 250,
                                  height: 250, // altura razoável
                                  child: Image.asset(
                                    monumento['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12), // espaçamento entre imagem e texto
                                // Texto do lado direito
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(monumento['description']),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Localização: ${monumento['location']}',
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Fechar'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Por enquanto não faz nada
                              },
                              child: const Text('Adicionar aos favoritos'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
