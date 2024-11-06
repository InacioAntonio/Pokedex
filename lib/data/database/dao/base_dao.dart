import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trabalhopokedex_application_1/data/database/entity/pokemon_database_entity.dart';

abstract class BaseDao {
  static const databaseVersion = 1;
  static const _databaseName = 'pokemon_database.db'; // Nome do banco

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
        _createPokemonTableV1(batch); // Criar a tabela para Pokémon
        await batch.commit();
      },
      version: databaseVersion,
    );
  }

  // Método para criar a tabela do Pokémon
  void _createPokemonTableV1(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE ${PokemonDatabaseContract.pokemonTable}(
        ${PokemonDatabaseContract.idColumn} TEXT PRIMARY KEY,
        ${PokemonDatabaseContract.nameEnglishColumn} TEXT NOT NULL,
        ${PokemonDatabaseContract.nameJapaneseColumn} TEXT NOT NULL,
        ${PokemonDatabaseContract.nameChineseColumn} TEXT NOT NULL,
        ${PokemonDatabaseContract.nameFrenchColumn} TEXT NOT NULL,
        ${PokemonDatabaseContract.type1Column} TEXT NOT NULL,
        ${PokemonDatabaseContract.type2Column} TEXT NOT NULL,
        ${PokemonDatabaseContract.hpColumn} INTEGER NOT NULL,
        ${PokemonDatabaseContract.attackColumn} INTEGER NOT NULL,
        ${PokemonDatabaseContract.defenseColumn} INTEGER NOT NULL,
        ${PokemonDatabaseContract.spAttackColumn} INTEGER NOT NULL,
        ${PokemonDatabaseContract.spDefenseColumn} INTEGER NOT NULL,
        ${PokemonDatabaseContract.speedColumn} INTEGER NOT NULL,
        ${PokemonDatabaseContract.imageUrlColumn} TEXT NOT NULL
      );
      ''',
    );
  }
}
