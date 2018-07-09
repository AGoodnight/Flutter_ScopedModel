import 'dart:async';
import 'dart:math';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app_scoped_model/data_service.dart';

class CounterModel extends Model{
  int _counter = 0;
  int get counter => _counter;
  List<String> _names = ['Dan','Ellie','Jack','Patty'];
  List<String> get names=> _names;
}

abstract class IncrementModel extends CounterModel{
  void increment(){
    _counter++;
    notifyListeners();
  }
}

abstract class DecrementModel extends CounterModel{
  void decrement(){
    _counter--;
    notifyListeners();
  }
}

abstract class ResetModel extends CounterModel{
  void reset(){
    _counter = 0;
    notifyListeners();
  }
}

class PokemonModel extends Model{
  static DataService service = new DataService();
  DataService dataService = service;
  Future _single = service.fetchPokemonByIndex(1);
  Future get data => _single;
  Future _type = service.fetchPokemonByType(1);
  Future get type => _type;
  Future _some = service.fetchSomePokemon();
  Future get some => _some;
}

abstract class RandomPokemon extends PokemonModel{
  void randomPokemon(){
    var _index = Random().nextInt(100);
    _single = dataService.fetchPokemonByIndex(_index).then((Pokemon pokemon){
      print(pokemon.name);
    });
  }
}

abstract class RandomPokemonType extends PokemonModel{
  void randomType(){
    var _index = Random().nextInt(4);
    _type = dataService.fetchPokemonByType(_index).then((PokemonType typeList){
      print(typeList.pokemon.toString());
    });
  }
}

class AppModel extends Model
  with PokemonModel, RandomPokemon, RandomPokemonType, CounterModel, IncrementModel, DecrementModel, ResetModel {}