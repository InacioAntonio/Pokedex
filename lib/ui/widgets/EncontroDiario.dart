import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:trabalhopokedex_application_1/core/pokemon_provider.dart';
import 'package:trabalhopokedex_application_1/data/database/entity/pokemon_database_entity.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class DailyEncounterScreen extends StatefulWidget {
  @override
  _DailyEncounterScreenState createState() => _DailyEncounterScreenState();
}

class _DailyEncounterScreenState extends State<DailyEncounterScreen> {
  Pokemon? _pokemonOfTheDay;
  bool _hasCaptured = false;
  final int pageSize = 10;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadDailyPokemon();
  }

  Future<void> _loadDailyPokemon() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;
    final lastCaptureDate = prefs.getString('lastCaptureDate');
    final pokemonOfTheDayId = prefs.getInt('pokemonOfTheDayId');

    if (lastCaptureDate != today) {
      // Generate a new random Pokémon for the day
      final newPokemon = await _generateRandomPokemon();
      await prefs.setInt('pokemonOfTheDayId', newPokemon.id);
      await prefs.setString('lastCaptureDate', today);
      setState(() {
        _pokemonOfTheDay = newPokemon;
        _hasCaptured = false;
      });
    } else {
      await _fetchPokemons(currentPage);
      final pokemons =
          Provider.of<PokemonProvider>(context, listen: false).pokemonList;
      setState(() {
        _pokemonOfTheDay =
            pokemons.firstWhere((pokemon) => pokemon.id == pokemonOfTheDayId);
        _hasCaptured = prefs.getBool('hasCaptured') ?? false;
      });
    }
  }

  Future<void> _fetchPokemons(int pageKey) async {
    try {
      final pokemonProvider =
          Provider.of<PokemonProvider>(context, listen: false);
      await pokemonProvider.fetchPokemons(pageKey, pageSize);
      final isLastPage = pokemonProvider.pokemonList.length < pageSize;
      final existingIds =
          pokemonProvider.pokemonList.map((pokemon) => pokemon.id).toSet();
      final newPokemons = pokemonProvider.pokemonList
          .where((pokemon) => !existingIds.contains(pokemon.id))
          .toList();

      if (isLastPage) {
        // Handle last page logic if needed
      } else {
        currentPage++;
      }
    } catch (error) {
      print('Error fetching pokemons: $error');
    }
  }

  Future<Pokemon> _generateRandomPokemon() async {
    await _fetchPokemons(currentPage);
    final pokemons =
        Provider.of<PokemonProvider>(context, listen: false).pokemonList;
    final random = Random();
    return pokemons[random.nextInt(pokemons.length)];
  }

  Future<void> _capturePokemon() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasCaptured', true);
    setState(() {
      _hasCaptured = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encontro Diário'),
      ),
      body: Center(
        child: _pokemonOfTheDay == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pokémon do dia: ${_pokemonOfTheDay!.name.english}',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  CachedNetworkImage(
                    imageUrl:
                        'http://10.0.2.2:3000/images/${_pokemonOfTheDay!.id.toString().padLeft(3, "0")}.png',
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _hasCaptured
                        ? null
                        : () {
                            _capturePokemon();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Você capturou ${_pokemonOfTheDay!.name.english}!'),
                              ),
                            );
                          },
                    child: Text(_hasCaptured ? 'Já capturado' : 'Capturar'),
                  ),
                ],
              ),
      ),
    );
  }
}
