import 'package:trabalhopokedex_application_1/data/database/entity/pokemon_database_entity.dart';
import 'package:trabalhopokedex_application_1/domain/base.dart';
import 'package:trabalhopokedex_application_1/domain/exception/mapper_exception.dart';
import 'package:trabalhopokedex_application_1/domain/name.dart';

import '../../domain/pokemon.dart';

class DatabaseMapper {
  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {
      print(entity.id);

      return Pokemon(
        id: int.parse(entity.id),
        name: Name(
          english: entity.nameEnglish,
          japanese: entity.nameJapanese,
          chinese: entity.nameChinese,
          french: entity.nameFrench,
        ),
        types: [entity.type1, entity.type2],
        base: Base(
          hp: entity.hp,
          attack: entity.attack,
          defense: entity.defense,
          spAttack: entity.spAttack,
          spDefense: entity.spDefense,
          speed: entity.speed,
        ),
      );
    } catch (e) {
      throw MapperException<PokemonDatabaseEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var entity in entities) {
      pokemons.add(toPokemon(entity));
    }
    return pokemons;
  }

  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    try {
      print(pokemon.id);
      return PokemonDatabaseEntity(
        id: pokemon.id.toString(),
        nameEnglish: pokemon.name.english!,
        nameChinese: pokemon.name.chinese!,
        nameJapanese: pokemon.name.japanese!,
        nameFrench: pokemon.name.french!,
        type1: pokemon.types![0],
        type2: pokemon.types!.length > 1 ? pokemon.types![1] : "",
        hp: pokemon.base.hp!,
        attack: pokemon.base.attack!,
        defense: pokemon.base.defense!,
        spAttack: pokemon.base.spAttack!,
        spDefense: pokemon.base.spDefense!,
        speed: pokemon.base.speed!,
        imageUrl:
            'http://10.0.2.2/images/pokemon/${pokemon.id.toString().padLeft(3, "0")}.png',
      );
    } catch (e) {
      throw MapperException<Pokemon, PokemonDatabaseEntity>(e.toString());
    }
  }

  List<PokemonDatabaseEntity> toPokemonDatabaseEntities(
      List<Pokemon> pokemons) {
    final List<PokemonDatabaseEntity> pokemonDatabaseEntities = [];
    for (var pokemon in pokemons) {
      pokemonDatabaseEntities.add(toPokemonDatabaseEntity(pokemon));
    }
    return pokemonDatabaseEntities;
  }
}
