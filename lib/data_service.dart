import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Pokemon {
  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  List abilities;

  Pokemon({
    this.id,
    this.name,
    this.baseExperience,
    this.height,
    this.isDefault,
    this.order,
    this.weight,
    this.abilities
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      baseExperience: json['baseExperience'],
      height: json['height'],
      isDefault: json['isDefault'],
      order: json['order'],
      weight: json['weight'],
      abilities: json['abilities']
    );
  }
}

class PokemonType{
  String name;
  List moves;
  List pokemon;

  PokemonType({
    this.name,
    this.moves,
    this.pokemon
  });

  factory PokemonType.fromJson(Map<String, dynamic> json){
    return PokemonType(
      name:json['name'],
      moves:(json['moves'] as List).map((e) => new Pokemon.fromJson(e)).toList(),
      pokemon:(json['pokemon'] as List).map((e) => new Pokemon.fromJson(e)).toList(),
    );
  }
}


class DataService {

  final String _endpoint = 'http://pokeapi.co/api/v2/';

  Future<Pokemon> fetchPokemonByIndex(int index) async{
      final response = await http.get(_endpoint+'pokemon/'+index.toString());

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON
        return Pokemon.fromJson(json.decode(response.body));
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load post');
      }
  }

  Future<PokemonType> fetchPokemonByType(int index) async{
    final response = await http.get(_endpoint+'type/'+index.toString());

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return PokemonType.fromJson(json.decode(response.body));

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<List<Pokemon>> fetchSomePokemon() async{
    final response = await http.get(_endpoint+'pokemon/');
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var results = json.decode(response.body);
      return (results['results'] as List).map((e) => new Pokemon.fromJson(e)).toList();


    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}