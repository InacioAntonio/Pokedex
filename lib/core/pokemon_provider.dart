import 'package:flutter/material.dart';
import 'package:trabalhopokedex_application_1/data/repository/pokemon_repository_impl.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class PokemonProvider with ChangeNotifier {
  final PokemonRepositoryImpl pokemonRepository;

  PokemonProvider({required this.pokemonRepository});

  List<Pokemon> _pokemonList = [];

  List<Pokemon> get pokemonList => _pokemonList;

  Future<void> fetchPokemons(int page, int limit) async {
    try {
      final pokemons =
          await pokemonRepository.getPokemons(page: page, limit: limit);
      _pokemonList.addAll(pokemons);
      print('Pokemons fetched: ${_pokemonList.length}');
      notifyListeners();
    } catch (e) {
      print('Error fetching pokemons: $e');
    }
  }
}
