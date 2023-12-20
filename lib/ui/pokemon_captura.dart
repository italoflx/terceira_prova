import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:terceira_prova/dao/pokemon_dao.dart';
import 'package:terceira_prova/entity/pokemon.dart';

Future<Pokemon> fetchPokemonDetails(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> pokemonData = jsonDecode(response.body);

    return Pokemon.fromJson(pokemonData);
  } else {
    throw Exception('Failed to load Pokémon details');
  }
}

Future<List<Pokemon>> fetchPokemonList(List<int> pokemonIds) async {
  final List<Pokemon> pokemonList = [];

  for (var id in pokemonIds) {
    final url = 'https://pokeapi.co/api/v2/pokemon/$id';
    final pokemon = await fetchPokemonDetails(url);
    pokemonList.add(pokemon);
  }

  return pokemonList;
}

class PokemonList extends StatefulWidget {
  final PokemonDao pokemonDao;
  const PokemonList({Key? key, required this.pokemonDao}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  late Future<List<Pokemon>> futurePokemonList;

  @override
  void initState() {
    super.initState();
    // Gere 6 números aleatórios entre 0 e 1017
    final List<int> randomPokemonIds =
        List.generate(6, (index) => Random().nextInt(1018));
    futurePokemonList = fetchPokemonList(randomPokemonIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
      ),
      body: Center(
        child: FutureBuilder<List<Pokemon>>(
          future: futurePokemonList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pokemon = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text('Name: ${pokemon.name}'),
                            Text(
                                'Base Experience: ${pokemon.baseExperience.toString()}'),
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ), // Adicione um espaço entre as informações
                        Image.network(
                          pokemon.image,
                          height: 100,
                          width: 100,
                        ), // Ajuste o tamanho conforme necessário
                        const SizedBox(
                          width: 16,
                        ), // Adicione um espaço entre as imagens
                        TextButton.icon(
                          icon: Image.network(
                            'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/74aec840-98e2-4a1e-b66a-e71e3eb0545e/dfbcoj1-4374cfa0-7a6a-4779-82c8-54751ea95e01.png/v1/fill/w_256,h_256/pokeball__pixel_art__by_lobina133_dfbcoj1-fullview.png?token=...',
                            height: 10,
                            width: 10,
                          ),
                          label: const Text(''),
                          onPressed: () {
                            final isCapturado = widget.pokemonDao.findPokemonById(pokemon.id);
                            if (isCapturado == null) {
                              widget.pokemonDao.insertPokemon(pokemon);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Pokémon ${pokemon.name} já capturado!'),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
