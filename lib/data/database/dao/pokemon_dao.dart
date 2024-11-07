import 'package:sqflite/sqflite.dart';
import 'package:trabalhopokedex_application_1/data/database/dao/base_dao.dart';
import 'package:trabalhopokedex_application_1/data/database/entity/pokemon_database_entity.dart';

class PokemonDao extends BaseDao {
  Future<List<PokemonDatabaseEntity>> selectAll({
    int? limit,
    int? offset,
  }) async {
    //print("POKEDAO");
    final Database db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query(
      PokemonDatabaseContract.pokemonTable,
      limit: limit,
      offset: offset,
      orderBy: '${PokemonDatabaseContract.idColumn} ASC',
    );
    return List.generate(maps.length, (i) {
      print(PokemonDatabaseEntity.fromJson(maps[i]));
      return PokemonDatabaseEntity.fromJson(maps[i]);
    });
  }

  Future<void> insert(PokemonDatabaseEntity entity) async {
    final Database db = await getDb();
    try {
      await db.insert(PokemonDatabaseContract.pokemonTable, entity.toJson());
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        await db.update(
          PokemonDatabaseContract.pokemonTable,
          entity.toJson(),
          where: '${PokemonDatabaseContract.idColumn} = ?',
          whereArgs: [entity.id],
        );
      } else {
        rethrow;
      }
    }
  }

  Future<void> insertAll(List<PokemonDatabaseEntity> entities) async {
    final Database db = await getDb();
    await db.transaction((transaction) async {
      for (final entity in entities) {
        try {
          print("INUTIL");
          await transaction.insert(
              // O problema ta aqui nesse lixo
              PokemonDatabaseContract.pokemonTable,
              entity.toJson());
          print("SAFADEZA");
        } on DatabaseException catch (e) {
          print("a");
          if (e.isUniqueConstraintError()) {
            await transaction.update(
              PokemonDatabaseContract.pokemonTable,
              entity.toJson(),
              where: '${PokemonDatabaseContract.idColumn} = ?',
              whereArgs: [entity.id],
            );
          } else {
            rethrow;
          }
        }
      }
    });
  }

  Future<void> deleteAll() async {
    final Database db = await getDb();
    await db.delete(PokemonDatabaseContract.pokemonTable);
  }
}

extension DatabaseExceptionExtension on DatabaseException {
  bool isUniqueConstraintError() {
    return this.isUniqueConstraintError();
  }
}
