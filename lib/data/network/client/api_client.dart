import 'package:dio/dio.dart';
import 'package:trabalhopokedex_application_1/data/network/entity/http_paged_result.dart';
import 'package:trabalhopokedex_application_1/domain/exception/network_exception.dart';
import 'package:trabalhopokedex_application_1/domain/pokemon.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()
      ..options.baseUrl = baseUrl
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
  }

  Future<List<PokemonDatabaseEntity>> getPokemons(
      {int? page, int? limit}) async {
    try {
      final response = await _dio.get(
        "/pokedex",
        queryParameters: {
          '_page': page,
          '_per_page': limit,
        },
      );

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
          statusCode: response.statusCode!,
          message: response.statusMessage ?? 'Unknown error',
        );
      } else if (response.statusCode == 200) {
        // Verifica se o tipo da resposta é uma lista ou um mapa
        if (response.data is List) {
          // Mapeia cada item da lista para `PokemonDatabaseEntity`

          // List<Map<String, dynamic>> pokemons = [];
          // for (var item in response.data) {
          //   pokemons.add(item as Map<String, dynamic>);
          // }
          // response.data = {"data": pokemons};
          // print("dados convertido: ${(response.data)}");
          final HttpPagedResult receivedData = // Problema esta aqui
              HttpPagedResult.fromJson(response.data as Map<String, dynamic>);
          print("teste2");
          return receivedData.data;
        } else if (response.data is Map<String, dynamic>) {
          // Caso a resposta seja um objeto com o formato de `HttpPagedResult`
          final HttpPagedResult receivedData =
              HttpPagedResult.fromJson(response.data);
          return receivedData.data;
        } else {
          throw Exception('Formato de resposta inesperado');
        }
      } else {
        throw Exception('Unknown error');
      }
    } catch (e) {
      print("Error fetching pokemons: $e");
      rethrow;
    }
  }
}
