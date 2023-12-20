import 'package:flutter/material.dart';
import 'package:floor/floor.dart';

@entity
class Pokemon {

  @PrimaryKey()
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final String image;

  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.image,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final sprites = json['sprites'] as Map<String, dynamic>;
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      baseExperience: json['base_experience'] as int,
      height: json['height'] as int,
      weight: json['weight'] as int,
      image: sprites['front_default'] as String,
    );
  }
}