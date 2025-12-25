import 'package:flutter/material.dart';
import '../services/favoritos_service.dart';

class DetalhesScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetalhesScreen({super.key, required this.item});

  @override
  State<DetalhesScreen> createState() => _DetalhesScreenState();
}

class _DetalhesScreenState extends State<DetalhesScreen> {
  bool isFavorito = false;

  @override
  void initState() {
    super.initState();
    // Verifica se o item já é favorito
    FavoritosService.isFavorito(widget.item['id']).then((value) {
      setState(() => isFavorito = value);
    });
  }

  Future<void> toggleFavorito() async {
    await FavoritosService.toggleFavorito(widget.item['id']);
    setState(() => isFavorito = !isFavorito);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Define breakpoint --> 600px
            final isWide = constraints.maxWidth > 600;

            if (isWide) {
              // Tela larga → Row
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: Image.asset(
                      widget.item['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDetailsColumn()),
                ],
              );
            } else {
              // Tela estreita → Column
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      widget.item['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailsColumn(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Extrair detalhes em um método para não repetir código
  Widget _buildDetailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.item['description'],
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Text(
          'Localização: ${widget.item['location']}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: toggleFavorito,
          icon: Icon(
            isFavorito ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          label: Text(
            isFavorito ? 'Remover dos favoritos' : 'Adicionar aos favoritos',
          ),
        ),
      ],
    );
  }

}

