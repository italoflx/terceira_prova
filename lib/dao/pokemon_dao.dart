import 'package:floor/floor.dart';
import 'package:terceira_prova/entity/pokemon.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM Pokemon')
  Future<List<Pokemon>> findAllPokemons();

  @Query('SELECT * FROM Pokemon WHERE id = :id')
  Stream<Pokemon?> findPokemonById(int id);

  @insert
  Stream<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);
}