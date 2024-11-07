// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDatabaseEntity _$PokemonDatabaseEntityFromJson(
        Map<String, dynamic> json) =>
    PokemonDatabaseEntity(
      id: json['id'] as String,
      nameEnglish: json['nameEnglish'] as String,
      nameJapanese: json['nameJapanese'] as String,
      nameChinese: json['nameChinese'] as String,
      nameFrench: json['nameFrench'] as String,
      type1: json['type1'] as String,
      type2: json['type2'] as String,
      HP: (json['HP'] as num).toInt(),
      Attack: (json['Attack'] as num).toInt(),
      Defense: (json['Defense'] as num).toInt(),
      spAttack: (json['spAttack'] as num).toInt(),
      spDefense: (json['spDefense'] as num).toInt(),
      speed: (json['Speed'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PokemonDatabaseEntityToJson(
        PokemonDatabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameEnglish': instance.nameEnglish,
      'nameJapanese': instance.nameJapanese,
      'nameChinese': instance.nameChinese,
      'nameFrench': instance.nameFrench,
      'type1': instance.type1,
      'type2': instance.type2,
      'HP': instance.HP,
      'Attack': instance.Attack,
      'Defense': instance.Defense,
      'spAttack': instance.spAttack,
      'spDefense': instance.spDefense,
      'Speed': instance.speed,
      'imageUrl': instance.imageUrl,
    };
