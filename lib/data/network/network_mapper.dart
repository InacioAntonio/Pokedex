import 'package:trabalhopokedex_application_1/data/network/entity/http_paged_result.dart'
    as http;
import 'package:trabalhopokedex_application_1/domain/base.dart';
import 'package:trabalhopokedex_application_1/domain/name.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class MapperException<T, U> implements Exception {
  final String message;
  MapperException(this.message);
}

class NetworkMapper {
  Pokemon toPokemon(http.PokemonDatabaseEntity entity) {
    try {
      return Pokemon(
        id: int.parse(entity.id!), // Converte id para int
        name: Name(
          english: entity.name!.english,
          japanese: entity.name!.japanese,
          chinese: entity.name!.chinese,
          french: entity.name!.french,
        ),
        types: entity.type,
        base: Base(
          hp: entity.base.hp ?? 0,
          attack: entity.base.attack ?? 0,
          defense: entity.base.defense ?? 0,
          spAttack: entity.base.spAttack ?? 0,
          spDefense: entity.base.spDefense ?? 0,
          speed: entity.base.speed ?? 0,
        ),
      );
    } catch (e) {
      throw MapperException<http.PokemonDatabaseEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<http.PokemonDatabaseEntity> entities) {
    print(entities[0].name!.english);
    final List<Pokemon> pokemons = [];
    for (var entity in entities) {
      pokemons.add(toPokemon(entity));
    }
    return pokemons;
  }
}
