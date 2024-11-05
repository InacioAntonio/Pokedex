import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:trabalhopokedex_application_1/data/database/dao/pokemon_dao.dart';
import 'package:trabalhopokedex_application_1/data/database/database_mapper.dart';
import 'package:trabalhopokedex_application_1/data/network/client/api_client.dart';
import 'package:trabalhopokedex_application_1/data/network/network_mapper.dart';
import 'package:trabalhopokedex_application_1/data/repository/pokemon_repository_impl.dart';

class ConfigureProviders {
  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {
    final apiClient = ApiClient(baseUrl: "http://10.0.2.2:3000");
    final networkMapper = NetworkMapper();
    final databaseMapper = DatabaseMapper();
    final pokemonDao = PokemonDao();

    final pokemonRepository = PokemonRepositoryImpl(
      apiClient: apiClient,
      networkMapper: networkMapper,
      databaseMapper: databaseMapper,
      pokemonDao: pokemonDao,
    );

    return ConfigureProviders(providers: [
      Provider<ApiClient>.value(value: apiClient),
      Provider<NetworkMapper>.value(value: networkMapper),
      Provider<DatabaseMapper>.value(value: databaseMapper),
      Provider<PokemonDao>.value(value: pokemonDao),
      Provider<PokemonRepositoryImpl>.value(value: pokemonRepository),
    ]);
  }
}
