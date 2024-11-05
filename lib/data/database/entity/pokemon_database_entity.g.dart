// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDatabaseEntity _$PokemonDatabaseEntityFromJson(
        Map<String, dynamic> json) =>
    PokemonDatabaseEntity(
      id: json['id'] as String,
      nameEnglish: json['name.english'] as String,
      nameJapanese: json['name.japanese'] as String,
      nameChinese: json['name.chinese'] as String,
      nameFrench: json['name.french'] as String,
      type1: json['type1'] as String,
      type2: json['type2'] as String,
      hp: (json['base.HP'] as num).toInt(),
      attack: (json['base.Attack'] as num).toInt(),
      defense: (json['base.Defense'] as num).toInt(),
      spAttack: (json['base.Sp. Attack'] as num).toInt(),
      spDefense: (json['base.Sp. Defense'] as num).toInt(),
      speed: (json['base.Speed'] as num).toInt(),
      imageUrl: json['image.url'] as String,
    );

Map<String, dynamic> _$PokemonDatabaseEntityToJson(
        PokemonDatabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name.english': instance.nameEnglish,
      'name.japanese': instance.nameJapanese,
      'name.chinese': instance.nameChinese,
      'name.french': instance.nameFrench,
      'type1': instance.type1,
      'type2': instance.type2,
      'base.HP': instance.hp,
      'base.Attack': instance.attack,
      'base.Defense': instance.defense,
      'base.Sp. Attack': instance.spAttack,
      'base.Sp. Defense': instance.spDefense,
      'base.Speed': instance.speed,
      'image.url': instance.imageUrl,
    };
