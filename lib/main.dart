import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabalhopokedex_application_1/core/pokemon_provider.dart';
import 'package:trabalhopokedex_application_1/data/database/dao/pokemon_dao.dart';
import 'package:trabalhopokedex_application_1/data/database/database_mapper.dart';
import 'package:trabalhopokedex_application_1/data/network/client/api_client.dart';
import 'package:trabalhopokedex_application_1/data/network/network_mapper.dart';
import 'package:trabalhopokedex_application_1/data/repository/pokemon_repository_impl.dart';
import 'package:trabalhopokedex_application_1/ui/widgets/EncontroDiario.dart';
import 'package:trabalhopokedex_application_1/ui/widgets/Pokedex.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(
            pokemonRepository: PokemonRepositoryImpl(
              apiClient: ApiClient(baseUrl: "http://10.0.2.2:3000"),
              networkMapper: NetworkMapper(),
              databaseMapper: DatabaseMapper(),
              pokemonDao: PokemonDao(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Tela Inicial da Pokedex'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Pokédex',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PokedexScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Encontro Diário',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyEncounterScreen(
                      pokemonRepository: PokemonRepositoryImpl(
                          apiClient: ApiClient(baseUrl: "http://10.0.2.2:3000"),
                          networkMapper: NetworkMapper(),
                          databaseMapper: DatabaseMapper(),
                          pokemonDao: PokemonDao()),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const CustomButton(text: 'Meus Pokémon'),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Cor de fundo do botão
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
