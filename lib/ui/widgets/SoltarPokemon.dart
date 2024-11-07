import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class DeletePokemonScreen extends StatefulWidget {
  final Pokemon pokemon;

  DeletePokemonScreen({required this.pokemon});

  @override
  _DeletePokemonScreenState createState() => _DeletePokemonScreenState();
}

class _DeletePokemonScreenState extends State<DeletePokemonScreen> {
  Future<void> _deletePokemon() async {
    final prefs = await SharedPreferences.getInstance();

    // Remover o ID do Pokémon capturado da lista de Pokémons capturados
    List<String> capturedPokemonIds =
        prefs.getStringList('capturedPokemons') ?? [];
    capturedPokemonIds.remove(widget.pokemon.id.toString());
    // Salvar a lista de IDs de volta no SharedPreferences.
    await prefs.setStringList('capturedPokemons', capturedPokemonIds);
    await prefs.setBool('hasCaptured', false);
    Navigator.pop(
        context, true); // Retorna true para indicar que o Pokémon foi apagado
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // O usuário deve confirmar ou cancelar
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Você tem certeza que deseja apagar este Pokémon?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o popup
              },
            ),
            TextButton(
              child: const Text('Apagar'),
              onPressed: () {
                _deletePokemon();
                Navigator.of(context).pop(); // Fecha o popup
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apagar Pokémon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pokémon: ${widget.pokemon.name.english}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            CachedNetworkImage(
              imageUrl:
                  'http://10.0.2.2:3000/images/${widget.pokemon.id.toString().padLeft(3, "0")}.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showConfirmationDialog,
              child: const Text('Apagar Pokémon'),
            ),
          ],
        ),
      ),
    );
  }
}
