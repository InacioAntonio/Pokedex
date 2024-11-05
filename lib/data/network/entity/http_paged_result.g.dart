// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpPagedResult _$HttpPagedResultFromJson(Map<String, dynamic> json) =>
    HttpPagedResult(
      first: (json['first'] as num).toInt(),
      prev: json['prev'],
      next: (json['next'] as num).toInt(),
      last: (json['last'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      items: (json['items'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PokemonDatabaseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HttpPagedResultToJson(HttpPagedResult instance) =>
    <String, dynamic>{
      'first': instance.first,
      'prev': instance.prev,
      'next': instance.next,
      'last': instance.last,
      'pages': instance.pages,
      'items': instance.items,
      'data': instance.data,
    };

PokemonDatabaseEntity _$PokemonDatabaseEntityFromJson(
        Map<String, dynamic> json) =>
    PokemonDatabaseEntity(
      id: json['id'] as String?,
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
      base: json['base'] == null
          ? null
          : Base.fromJson(json['base'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonDatabaseEntityToJson(
        PokemonDatabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'base': instance.base,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      english: json['english'] as String,
      japanese: json['japanese'] as String,
      chinese: json['chinese'] as String,
      french: json['french'] as String,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'english': instance.english,
      'japanese': instance.japanese,
      'chinese': instance.chinese,
      'french': instance.french,
    };

Base _$BaseFromJson(Map<String, dynamic> json) => Base(
      hp: (json['HP'] as num).toInt(),
      attack: (json['Attack'] as num).toInt(),
      defense: (json['Defense'] as num).toInt(),
      spAttack: (json['spAttack'] as num).toInt(),
      spDefense: (json['spDefense'] as num).toInt(),
      speed: (json['Speed'] as num).toInt(),
    );

Map<String, dynamic> _$BaseToJson(Base instance) => <String, dynamic>{
      'HP': instance.hp,
      'Attack': instance.attack,
      'Defense': instance.defense,
      'spAttack': instance.spAttack,
      'spDefense': instance.spDefense,
      'Speed': instance.speed,
    };