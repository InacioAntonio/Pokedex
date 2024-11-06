import 'package:json_annotation/json_annotation.dart';

part 'pokemon_database_entity.g.dart'; // Certifique-se de que o nome está correto

@JsonSerializable()
class PokemonDatabaseEntity {
  final String id;
  @JsonKey(name: 'name_english')
  final String nameEnglish;
  @JsonKey(name: 'name_japanese')
  final String nameJapanese;
  @JsonKey(name: 'name_chinese')
  final String nameChinese;
  @JsonKey(name: 'name_french')
  final String nameFrench;
  final String type1;
  final String type2;
  @JsonKey(name: 'HP')
  final int hp;
  @JsonKey(name: 'Attack')
  final int attack;
  @JsonKey(name: 'Defense')
  final int defense;
  @JsonKey(name: 'spAttack')
  final int spAttack;
  @JsonKey(name: 'spDefense')
  final int spDefense;
  @JsonKey(name: 'Speed')
  final int speed;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  PokemonDatabaseEntity({
    required this.id,
    required this.nameEnglish,
    required this.nameJapanese,
    required this.nameChinese,
    required this.nameFrench,
    required this.type1,
    required this.type2,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
    required this.imageUrl,
  });

  factory PokemonDatabaseEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDatabaseEntityFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonDatabaseEntityToJson(this);
}

abstract class PokemonDatabaseContract {
  static const String pokemonTable = "pokemon_table";
  static const String idColumn = "id";
  static const String nameEnglishColumn = "name_english";
  static const String nameJapaneseColumn = "name_japanese";
  static const String nameChineseColumn = "name_chinese";
  static const String nameFrenchColumn = "name_french";
  static const String type1Column = "type1";
  static const String type2Column = "type2";
  static const String hpColumn = "hp";
  static const String attackColumn = "attack";
  static const String defenseColumn = "defense";
  static const String spAttackColumn = "spAttack";
  static const String spDefenseColumn = "spDefense";
  static const String speedColumn = "Speed";
  static const String imageUrlColumn = "image_url";
}
