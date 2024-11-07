import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalhopokedex_application_1/core/pokemon_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';
import 'package:trabalhopokedex_application_1/ui/widgets/SoltarPokemon.dart'; // Para caching de imagens

class MeusPokemonsScreen extends StatefulWidget {
  @override
  _MeusPokemonsScreenState createState() => _MeusPokemonsScreenState();
}

class _MeusPokemonsScreenState extends State<MeusPokemonsScreen> {
  List<Pokemon> _capturedPokemons = [];

  @override
  void initState() {
    super.initState();
    _loadCapturedPokemons();
  }

  Future<void> _loadCapturedPokemons() async {
    print("AAAA");
    final prefs = await SharedPreferences.getInstance();
    List<String> capturedPokemonIds =
        prefs.getStringList('capturedPokemons') ?? [];
    // capturedPokemonIds.clear();
    print(capturedPokemonIds);
    List<int> capturedIds =
        capturedPokemonIds.map((id) => int.parse(id)).toList();
    final pokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);
    await pokemonProvider.fetchPokemons(
        1, 100); // Fetch all Pokemons or adjust as needed
    final allPokemons = pokemonProvider.pokemonList;

    setState(() {
      _capturedPokemons.clear();
      for (var pokemon in allPokemons) {
        if (capturedIds.contains(pokemon.id) &&
            !_capturedPokemons.any((p) => p.id == pokemon.id)) {
          _capturedPokemons.add(pokemon);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pokémons'),
      ),
      body: _capturedPokemons.isEmpty
          ? Center(child: const Text('Você ainda não capturou nenhum Pokémon.'))
          : ListView.builder(
              itemCount: _capturedPokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _capturedPokemons[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl:
                        'http://10.0.2.2:3000/images/${pokemon.id.toString().padLeft(3, "0")}.png',
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  title: Text(pokemon.name.english!),
                  subtitle: Text('Tipo: ${pokemon.types![0]}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DeletePokemonScreen(pokemon: pokemon),
                        ),
                      ).then((value) {
                        if (value == true) {
                          setState(() {
                            _capturedPokemons.remove(pokemon);
                          });
                        }
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}


//Abre a Tela dos meus Pokemons