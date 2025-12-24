import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PraiasScreen extends StatefulWidget {
  const PraiasScreen({super.key});

  @override
  State<PraiasScreen> createState() => _PraiasScreenState();
}

class _PraiasScreenState extends State<PraiasScreen> {
  List<Map<String, dynamic>> praias = [];

  @override
  void initState() {
    super.initState();
    loadPraias();
  }

  Future<void> loadPraias() async {
    final String jsonString = await rootBundle.loadString('data/pointsOfInterest.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    // Filtra apenas os itens do tipo "Praia"
    final List<Map<String, dynamic>> praiasFiltradas = jsonData
        .where((item) => item['tipo'] == 'Praia')
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    setState(() {
      praias = praiasFiltradas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Praias')),
      body: praias.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: praias.length,
              itemBuilder: (context, index) {
                final praia = praias[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      praia['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(praia['name']),
                    subtitle: Text(praia['short_description']),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(praia['name']),
                          content: SingleChildScrollView(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Imagem do lado esquerdo
                                SizedBox(
                                  width: 250,
                                  height: 250, // altura razoável
                                  child: Image.asset(
                                    praia['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 12), // espaçamento entre imagem e texto
                                // Texto do lado direito
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(praia['description']),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Localização: ${praia['location']}',
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

