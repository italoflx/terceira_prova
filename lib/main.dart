import 'package:flutter/material.dart';
import 'package:terceira_prova/dao/pokemon_dao.dart';
import 'package:terceira_prova/database/database.dart';
import 'package:terceira_prova/ui/pokemon_captura.dart';
import 'package:terceira_prova/ui/pokemon_list.dart';
import 'package:terceira_prova/widgets/tela_sobre.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
    .databaseBuilder('app_database.db')
    .build();
  
  final pokemonDao = database.pokemonDao;

  runApp(PokemonApp(pokemonDao: pokemonDao));
}
//void main() => runApp(const PokemonApp());

class PokemonApp extends StatelessWidget {
  final PokemonDao pokemonDao;
  const PokemonApp({Key? key, required this.pokemonDao}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PokemonHome(pokemonDao: pokemonDao,),
    );
  }
}

class PokemonHome extends StatefulWidget {
  final PokemonDao pokemonDao;

  const PokemonHome({Key? key, required this.pokemonDao}) : super(key: key);

  @override
  State<PokemonHome> createState() => _PokemonHomeState();
}

class _PokemonHomeState extends State<PokemonHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon App'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaSobre()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Capturados'),
              onTap: () {
                Navigator.pop(context);
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPokemonCapturado(pokemonDao : widget.pokemonDao)),
                );
              },
            ),
           
            ListTile(
              title: const Text('Tela Captura'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PokemonList(pokemonDao : widget.pokemonDao)),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome to Pokémon App'),
      ),
    );
  }
}
