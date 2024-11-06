// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDatabaseEntity _$PokemonDatabaseEntityFromJson(
        Map<String, dynamic> json) =>
    PokemonDatabaseEntity(
      id: json['id'] as String,
      nameEnglish: json['name_english'] as String,
      nameJapanese: json['name_japanese'] as String,
      nameChinese: json['name_chinese'] as String,
      nameFrench: json['name_french'] as String,
      type1: json['type1'] as String,
      type2: json['type2'] as String,
      hp: (json['HP'] as num).toInt(),
      attack: (json['Attack'] as num).toInt(),
      defense: (json['Defense'] as num).toInt(),
      spAttack: (json['spAttack'] as num).toInt(),
      spDefense: (json['spDefense'] as num).toInt(),
      speed: (json['Speed'] as num).toInt(),
      imageUrl: json['image_url'] as String,
    );

Map<String, dynamic> _$PokemonDatabaseEntityToJson(
        PokemonDatabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name_english': instance.nameEnglish,
      'name_japanese': instance.nameJapanese,
      'name_chinese': instance.nameChinese,
      'name_french': instance.nameFrench,
      'type1': instance.type1,
      'type2': instance.type2,
      'HP': instance.hp,
      'Attack': instance.attack,
      'Defense': instance.defense,
      'spAttack': instance.spAttack,
      'spDefense': instance.spDefense,
      'Speed': instance.speed,
      'image_url': instance.imageUrl,
    };
