import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/pokemon_dao.dart';
import 'package:terceira_prova/entity/pokemon.dart';
import 'package:terceira_prova/ui/pokemon_captura.dart';

class TelaDetalhesPokemon extends StatelessWidget {
  final PokemonDao pokemonDao;
  final Pokemon pokemon;

  const TelaDetalhesPokemon({Key? key, required this.pokemon, required this.pokemonDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pokémon'),
      ),
      body: FutureBuilder<Pokemon>(
        future: fetchPokemonDetails('https://pokeapi.co/api/v2/pokemon/${pokemon.id}'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Name: ${pokemon.name}'),
                // Outros detalhes do Pokémon
              ],
            );
          } else {
            return const Center(
              child: Text('Falha ao carregar os detalhes do Pokémon.'),
            );
          }
        },
      ),
    );
  }
}
