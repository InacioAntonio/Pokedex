import 'package:trabalhopokedex_application_1/data/database/dao/pokemon_dao.dart';
import 'package:trabalhopokedex_application_1/data/database/database_mapper.dart';
import 'package:trabalhopokedex_application_1/data/network/client/api_client.dart';
import 'package:trabalhopokedex_application_1/data/network/network_mapper.dart';
import 'package:trabalhopokedex_application_1/data/repository/pokemon_repository.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final ApiClient apiClient;
  final NetworkMapper networkMapper;
  final DatabaseMapper databaseMapper;
  final PokemonDao pokemonDao; // DAO gerado pelo Floor

  PokemonRepositoryImpl({
    required this.pokemonDao,
    required this.databaseMapper,
    required this.apiClient,
    required this.networkMapper,
  });

  @override
  Future<List<Pokemon>> getPokemons(
      {required int page, required int limit}) async {
    print("TESTE");
    // Tenta carregar os pokémons do banco de dados
    final dbEntities = await pokemonDao.selectAll(
        limit: limit, offset: (page * limit) - limit);
    print("BUG DO MILENIUM");

    // Se o banco de dados tiver dados, retorna eles
    if (dbEntities.isNotEmpty) {
      return databaseMapper.toPokemons(dbEntities);
    }

    // Caso contrário, busca os dados pela API
    final networkEntity = await apiClient.getPokemons(page: page, limit: limit);
    print("VSFD TANIRO");
    final pokemons = networkMapper.toPokemons(networkEntity);

    // Salva os dados no banco local para cache
    await pokemonDao
        .insertAll(databaseMapper.toPokemonDatabaseEntities(pokemons));

    // // Retorna os pokémons recebidos da API
    return pokemons;
  }
}
