import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/pokemon_dao.dart';
import 'package:terceira_prova/entity/pokemon.dart';

class TelaSoltarPokemon extends StatelessWidget {
  final PokemonDao pokemonDao;
  final Pokemon pokemon; // Recebe o ID do Pokémon

  const TelaSoltarPokemon({Key? key, required this.pokemonDao, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soltar Pokémon'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tem certeza de que deseja soltar este Pokémon?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                pokemonDao.deletePokemon(pokemon);
                Navigator.pop(context); // Voltar para a tela anterior
              },
              child: const Text('Soltar'),
            ),
          ],
        ),
      ),
    );
  }
}
