import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({required int page, required int limit});
}
