import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:trabalhopokedex_application_1/data/database/entity/pokemon_database_entity.dart';

abstract class BaseDao {
  static const databaseVersion = 1;
  static const _databaseName = 'pokemon_database.db';

  Database? _database;

  @protected
  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createPokemonTableV1(batch);
        await batch.commit();
      },
      version: databaseVersion,
    );
  }

  void _createPokemonTableV1(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE ${PokemonDatabaseContract.pokemonTable} (
        ${PokemonDatabaseContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${PokemonDatabaseContract.nameEnglishColumn} TEXT,
        ${PokemonDatabaseContract.nameJapaneseColumn} TEXT,
        ${PokemonDatabaseContract.nameChineseColumn} TEXT,
        ${PokemonDatabaseContract.nameFrenchColumn} TEXT,
        ${PokemonDatabaseContract.typesColumn} TEXT, -- Armazenado como JSON String
        ${PokemonDatabaseContract.hpColumn} INTEGER,
        ${PokemonDatabaseContract.attackColumn} INTEGER,
        ${PokemonDatabaseContract.defenseColumn} INTEGER,
        ${PokemonDatabaseContract.spAttackColumn} INTEGER,
        ${PokemonDatabaseContract.spDefenseColumn} INTEGER,
        ${PokemonDatabaseContract.speedColumn} INTEGER,
        ${PokemonDatabaseContract.imageUrlColumn} TEXT
      );
      ''',
    );
  }
}
