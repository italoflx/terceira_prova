import 'dart:async';

import 'package:floor/floor.dart';
import 'package:terceira_prova/dao/pokemon_dao.dart';
import 'package:terceira_prova/entity/pokemon.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Pokemon])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}