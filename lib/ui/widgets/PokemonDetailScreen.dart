import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  final String imageUrl;
  final List<String> types;

  const PokemonDetailScreen(
      {super.key,
      required this.pokemon,
      required this.imageUrl,
      required this.types});
  Color _getBackgroundColor() {
    if (types.contains('Fire')) {
      return Colors.red[100]!;
    } else if (types.contains('Water')) {
      return Colors.blue[100]!;
    } else if (types.contains('Grass') || types.contains('Bug')) {
      return Colors.green[100]!;
    } else if (types.contains('Electric')) {
      return Colors.yellow[100]!;
    } else if (types.contains('Ghost')) {
      return Colors.purple[100]!;
    } else if (types.contains('Psychic') || types.contains('Poison')) {
      return Colors.purple[100]!;
    } else {
      return Colors.grey!; // Cor padrão caso não encontre um tipo específico
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(),
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[200],
              child: CachedNetworkImage(
                  imageUrl: imageUrl), // Substitua pela URL da imagem
            ),
            Text(
              pokemon.name.english!.toLowerCase(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTypeChip(types[0]),
                if (types.length > 1 && types[1] != "") _buildTypeChip(types[1])
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Base Stats",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildStatBar("HP", pokemon.base.hp!),
            _buildStatBar("ATK", pokemon.base.attack!),
            _buildStatBar("DEF", pokemon.base.defense!),
            _buildStatBar("SPEED", pokemon.base.speed!),
            _buildStatBar("SP. DEF ", pokemon.base.spDefense!),
            _buildStatBar("SP. ATK ", pokemon.base.spAttack!)
          ],
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    final Map<String, Color> typeColors = {
      'Fire': Colors.red,
      'Water': Colors.blue,
      'Grass': Colors.green,
      'Electric': Colors.yellow,
      'Ice': Colors.lightBlueAccent,
      'Fighting': Colors.orange,
      'Poison': Colors.purple,
      'Ground': Colors.brown,
      'Flying': Colors.indigo,
      'Psychic': Colors.pink,
      'Bug': Colors.lightGreen,
      'Rock': Colors.grey,
      'Ghost': Colors.deepPurple,
      'Dragon': Colors.indigoAccent,
      'Dark': Colors.black,
      'Steel': Colors.blueGrey,
      'Fairy': Colors.pinkAccent,
      "": Colors.transparent
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Chip(
        label: Text(
          type,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: typeColors[type] ??
            Colors.grey, // Cor padrão se o tipo não estiver no mapa
      ),
    );
  }

  Widget _buildStatBar(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 300,
              color: Colors.red,
              backgroundColor: Colors.grey[300],
            ),
          ),
          const SizedBox(width: 10),
          Text(value.toString()),
        ],
      ),
    );
  }
}
