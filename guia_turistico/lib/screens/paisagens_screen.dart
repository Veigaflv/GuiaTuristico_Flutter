import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PaisagensScreen extends StatefulWidget {
  const PaisagensScreen({super.key});

  @override
  State<PaisagensScreen> createState() => _PaisagensScreenState();
}

class _PaisagensScreenState extends State<PaisagensScreen> {
  List<Map<String, dynamic>> paisagens = [];

  @override
  void initState() {
    super.initState();
    loadPaisagens();
  }

  Future<void> loadPaisagens() async {
    final String jsonString = await rootBundle.loadString('data/pointsOfInterest.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Filtra apenas os itens do tipo "Paisagem"
    final List<Map<String, dynamic>> paisagensFiltradas = jsonData
        .where((item) => item['tipo'] == 'Paisagem')
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    setState(() {
      paisagens = paisagensFiltradas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paisagens')),
      body: paisagens.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: paisagens.length,
              itemBuilder: (context, index) {
                final paisagem = paisagens[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      paisagem['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(paisagem['name']),
                    subtitle: Text(paisagem['short_description']),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(paisagem['name']),
                          content: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Imagem do lado esquerdo
                                SizedBox(
                                  width: 250,
                                  height: 250, // altura razoável
                                  child: Image.asset(
                                    paisagem['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12), // espaçamento entre imagem e texto
                                // Texto do lado direito
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(paisagem['description']),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Localização: ${paisagem['location']}',
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