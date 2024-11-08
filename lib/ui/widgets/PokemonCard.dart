import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  String name;
  List<String> types;
  Color color;
  String imageUrl;

  PokemonCard({
    super.key,
    required this.name,
    required this.types,
    required this.color,
    required this.imageUrl,
  });
  Color getColorByType(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red.withOpacity(0.7);
      case 'water':
        return Colors.blue.withOpacity(0.7);
      case 'grass':
        return Colors.green.withOpacity(0.7);
      case 'electric':
        return Colors.yellow.withOpacity(0.7);
      case 'psychic':
        return Colors.purple.withOpacity(0.7);
      case 'ice':
        return Colors.cyan.withOpacity(0.7);
      case 'dragon':
        return Colors.indigo.withOpacity(0.7);
      case 'dark':
        return Colors.black.withOpacity(0.7);
      case 'fairy':
        return Colors.pink.withOpacity(0.7);
      case 'bug':
        return const Color.fromARGB(255, 106, 213, 110).withOpacity(0.7);
      case 'poison':
        return Colors.purple.withOpacity(0.7);
      case 'flying':
        return const Color.fromARGB(255, 124, 137, 206);
      case "":
        return Colors.transparent;
      default:
        return Colors.grey.withOpacity(0.7); // Cor padrão
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 4,
            children: [
              Chip(
                label: Text(types[0]),
                backgroundColor: getColorByType(types[0]),
              ),
              if (types.length > 1 && types[1] != "")
                Chip(
                  label: Text(types[1] ?? ""),
                  backgroundColor:
                      getColorByType(types[1]) ?? Colors.transparent,
                )
            ],
            // children: types
            //     .map((type) => Chip(
            //           label: Text(type),
            //           backgroundColor: Colors.white.withOpacity(0.7),
            //         ))
            //     .toList(),
          ),
        ],
      ),
    );
  }
}
