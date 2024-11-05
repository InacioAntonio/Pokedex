import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:trabalhopokedex_application_1/core/pokemon_provider.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';
import 'package:trabalhopokedex_application_1/ui/widgets/PokemonCard.dart';

class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  late final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final pokemonProvider =
          Provider.of<PokemonProvider>(context, listen: false);
      await pokemonProvider.fetchPokemons(pageKey, 10);
      final isLastPage = pokemonProvider.pokemonList.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(pokemonProvider.pokemonList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(pokemonProvider.pokemonList, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Color getColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow;
      case 'psychic':
        return Colors.purple;
      case 'ice':
        return Colors.cyan;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.black;
      case 'fairy':
        return const Color.fromARGB(255, 225, 78, 127);
      case 'bug':
        return const Color.fromARGB(255, 106, 213, 110);
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      default:
        return Colors.grey; // Cor padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedGridView<int, Pokemon>(
          pagingController: _pagingController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          builderDelegate: PagedChildBuilderDelegate<Pokemon>(
            itemBuilder: (context, pokemon, index) => PokemonCard(
              name: pokemon.name.english!,
              types: pokemon.types is List<String>
                  ? pokemon.types as List<String>
                  : ['Unknown'],
              color: getColorByType(pokemon.types![0]),
              imageUrl:
                  'http://10.0.2.2:3000/images/${pokemon.id.toString().padLeft(3, "0")}.png',
            ),
          ),
        ),
      ),
    );
  }
}
