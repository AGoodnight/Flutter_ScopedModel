import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app_scoped_model/app/custom_list_tile.dart';
import 'package:flutter_app_scoped_model/data_service.dart';

class CustomList extends StatefulWidget{

  CustomList({
      this.height,
      this.data
  }) : super();

  final Future<List<Pokemon>> data;
  final double height;



  @override
  createState() => CustomListState(height,data);
}

class CustomListState extends State<CustomList>{

  CustomListState(this.height,this.data);

  final double height;
  final Future<List<Pokemon>> data;

  Widget _buildItem(item){
    return new CustomListTile(item);
  }

  Widget _buildList(){
    return new FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('loading...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return new ListView.builder(
                  itemCount: snapshot.data.length ,
                  itemBuilder: (context,i){
                  return _buildItem(snapshot.data[i]);
                  },
                );
          }
        },
    );
  }

  @override
  Widget build(BuildContext context){
    debugPrint(data.toString());
    return new Container(
      height:height,
      child:_buildList()
    );
  }

  void animateIcon(){

  }
}