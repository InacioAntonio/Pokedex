import 'package:json_annotation/json_annotation.dart';

part 'http_paged_result.g.dart';

@JsonSerializable()
class HttpPagedResult {
  int first;
  dynamic prev;
  int next;
  int last;
  int pages;
  int items;
  List<PokemonDatabaseEntity> data;

  HttpPagedResult({
    required this.first,
    required this.prev,
    required this.next,
    required this.last,
    required this.pages,
    required this.items,
    required this.data,
  });

  factory HttpPagedResult.fromJson(Map<String, dynamic> json) =>
      _$HttpPagedResultFromJson(json);

  Map<String, dynamic> toJson() => _$HttpPagedResultToJson(this);
}

// Representa um Pokémon no banco de dados
@JsonSerializable()
class PokemonDatabaseEntity {
  String? id;
  Name? name;
  List<String>? type;
  Base base;

  PokemonDatabaseEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
  });

  factory PokemonDatabaseEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDatabaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDatabaseEntityToJson(this);
}

// Classe que representa o nome do Pokémon em vários idiomas
@JsonSerializable()
class Name {
  String english;
  String japanese;
  String chinese;
  String french;

  Name({
    required this.english,
    required this.japanese,
    required this.chinese,
    required this.french,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  Map<String, dynamic> toJson() => _$NameToJson(this);
}

// Classe que representa as estatísticas base de um Pokémon
@JsonSerializable()
class Base {
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

  Base({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
  });

  factory Base.fromJson(Map<String, dynamic> json) => _$BaseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseToJson(this);
}
