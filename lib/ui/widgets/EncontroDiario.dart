import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:trabalhopokedex_application_1/data/repository/pokemon_repository_impl.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class DailyEncounterScreen extends StatefulWidget {
  final PokemonRepositoryImpl pokemonRepository;

  const DailyEncounterScreen({super.key, required this.pokemonRepository});

  @override
  _DailyEncounterScreenState createState() => _DailyEncounterScreenState();
}

class _DailyEncounterScreenState extends State<DailyEncounterScreen> {
  Pokemon? _pokemonOfTheDay;
  bool _hasCaptured = false;

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
      final pokemons =
          await widget.pokemonRepository.getPokemons(page: 1, limit: 100);
      setState(() {
        _pokemonOfTheDay =
            pokemons.firstWhere((pokemon) => pokemon.id == pokemonOfTheDayId);
        _hasCaptured = prefs.getBool('hasCaptured') ?? false;
      });
    }
  }

  Future<Pokemon> _generateRandomPokemon() async {
    final pokemons =
        await widget.pokemonRepository.getPokemons(page: 1, limit: 100);
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
                    'Pokémon do dia: ${_pokemonOfTheDay!.name}',
                    style: TextStyle(fontSize: 24),
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
                                    'Você capturou ${_pokemonOfTheDay!.name}!'),
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
