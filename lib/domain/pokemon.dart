import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trabalhopokedex_application_1/domain/base.dart';
import 'package:trabalhopokedex_application_1/domain/name.dart';

part 'pokemon.freezed.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required Name name,
    required List<String>? types,
    required Base base,
  }) = _Pokemon;
}
