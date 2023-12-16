// Definição da classe que representa o Pokémon
import 'package:floor/floor.dart';

@entity
class Pokemon {
  @PrimaryKey()
  final int id;

  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final String imageUrl;

  Pokemon(this.id, this.name, this.baseExperience, this.height, this.weight, this.imageUrl);
}