import 'package:trabalhopokedex_application_1/data/database/entity/pokemon_database_entity.dart';
import 'package:trabalhopokedex_application_1/domain/base.dart';
import 'package:trabalhopokedex_application_1/domain/exception/mapper_exception.dart';
import 'package:trabalhopokedex_application_1/domain/name.dart';

import '../../domain/pokemon.dart';

class DatabaseMapper {
  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {
      print(entity.id);
      print(entity.speed);
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
          hp: entity.HP ?? 0,
          attack: entity.Attack ?? 0,
          defense: entity.Defense ?? 0,
          spAttack: entity.spAttack ?? 0,
          spDefense: entity.spDefense ?? 0,
          speed: entity.speed ?? 0,
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
    //Nao entra aqui
    try {
      print(pokemon.id);
      print(pokemon.base.speed);
      return PokemonDatabaseEntity(
        id: pokemon.id.toString(),
        nameEnglish: pokemon.name.english!,
        nameChinese: pokemon.name.chinese!,
        nameJapanese: pokemon.name.japanese!,
        nameFrench: pokemon.name.french!,
        type1: pokemon.types![0],
        type2: pokemon.types!.length > 1 ? pokemon.types![1] : "",
        HP: pokemon.base.hp ?? 0,
        Attack: pokemon.base.attack ?? 0,
        Defense: pokemon.base.defense ?? 0,
        spAttack: pokemon.base.spAttack ?? 0,
        spDefense: pokemon.base.spDefense ?? 0,
        speed: pokemon.base.speed ?? 0,
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
