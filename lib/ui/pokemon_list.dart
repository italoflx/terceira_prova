import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/pokemon_dao.dart';
import 'package:terceira_prova/entity/pokemon.dart';
import 'package:terceira_prova/ui/pokemon_delete.dart';
import 'package:terceira_prova/ui/pokemon_detalhes.dart';

class TelaPokemonCapturado extends StatelessWidget {
  final PokemonDao pokemonDao;

  const TelaPokemonCapturado({Key? key, required this.pokemonDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Capturado'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: pokemonDao.findAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDetalhesPokemon(pokemon: pokemon, pokemonDao: pokemonDao),
                      ),
                    );
                  },
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaSoltarPokemon(pokemon: pokemon, pokemonDao: pokemonDao),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(pokemon.name),
                    // Outros detalhes do Pokémon
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('Nenhum Pokémon capturado ainda.'),
            );
          }
        },
      ),
    );
  }
}
