import 'package:json_annotation/json_annotation.dart';

part 'pokemon_database_entity.g.dart'; // Certifique-se de que o nome está correto

@JsonSerializable()
class PokemonDatabaseEntity {
  final String id;
  // @JsonKey(name: 'name_english')
  final String nameEnglish;
  //@JsonKey(name: 'name_japanese')
  final String nameJapanese;
  //@JsonKey(name: 'name_chinese')
  final String nameChinese;
  //@JsonKey(name: 'name_french')
  final String nameFrench;
  final String type1;
  final String type2;
  @JsonKey(name: 'HP')
  final int HP;
  @JsonKey(name: 'Attack')
  final int Attack;
  @JsonKey(name: 'Defense')
  final int Defense;
  @JsonKey(name: 'spAttack')
  final int spAttack;
  @JsonKey(name: 'spDefense')
  final int spDefense;
  @JsonKey(name: 'Speed')
  final int speed;
  //@JsonKey(name: 'image_url')
  final String imageUrl;
  PokemonDatabaseEntity({
    required this.id,
    required this.nameEnglish,
    required this.nameJapanese,
    required this.nameChinese,
    required this.nameFrench,
    required this.type1,
    required this.type2,
    required this.HP,
    required this.Attack,
    required this.Defense,
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
  static const String nameEnglishColumn = "nameEnglish";
  static const String nameJapaneseColumn = "nameJapanese";
  static const String nameChineseColumn = "nameChinese";
  static const String nameFrenchColumn = "nameFrench";
  static const String type1Column = "type1";
  static const String type2Column = "type2";
  static const String hpColumn = "HP";
  static const String attackColumn = "Attack";
  static const String defenseColumn = "Defense";
  static const String spAttackColumn = "spAttack";
  static const String spDefenseColumn = "spDefense";
  static const String speedColumn = "Speed";
  static const String imageUrlColumn = "imageUrl";
}
