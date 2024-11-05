import 'package:trabalhopokedex_application_1/data/database/dao/pokemon_dao.dart';
import 'package:trabalhopokedex_application_1/data/database/database_mapper.dart';
import 'package:trabalhopokedex_application_1/data/network/client/api_client.dart';
import 'package:trabalhopokedex_application_1/data/network/network_mapper.dart';
import 'package:trabalhopokedex_application_1/data/repository/pokemon_repository.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final ApiClient apiClient;
  final NetworkMapper networkMapper;
  final PokemonDao pokemonDao;
  final DatabaseMapper databaseMapper;

  PokemonRepositoryImpl({
    required this.pokemonDao,
    required this.databaseMapper,
    required this.apiClient,
    required this.networkMapper,
  });

  @override
  Future<List<Pokemon>> getPokemons(
      {required int page, required int limit}) async {
    // Tentar carregar a partir do banco de dados
    final dbEntities = await pokemonDao.selectAll(
        limit: limit, offset: (page * limit) - limit);
    // Se o dado já existe, carregar esse dado.
    if (dbEntities.isNotEmpty) {
      return databaseMapper.toPokemons(dbEntities);
    }
    // Caso contrário, buscar pela API remota
    final networkEntity = await apiClient.getPokemons(page: page, limit: limit);
    final pokemons = networkMapper.toPokemons(networkEntity);
    // E salvar os dados no banco local para cache
    // await pokemonDao
    //     .insertAll(databaseMapper.toPokemonDatabaseEntities(pokemons));
    return pokemons;
  }
}
