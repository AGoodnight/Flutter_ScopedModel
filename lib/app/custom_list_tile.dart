import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import 'package:flutter_app_scoped_model/data_service.dart';

class CustomListTile extends StatefulWidget{
  CustomListTile(this.itemData);

  final Pokemon itemData;

  @override
  createState() => CustomListTileState(itemData);
}

class CustomListTileState extends State<CustomListTile> with TickerProviderStateMixin{
  CustomListTileState(this.itemData);

  final GlobalKey iconKey = new GlobalKey();
  final Pokemon itemData;

  double iconRotation = 0.0;
  Animation animation;

  @override
  Widget build(BuildContext context){
    debugPrint(itemData.toString());
    return new Container(
        color:Colors.white70,
        child: new ListTile(
            subtitle:new Text("Click Me"),
            leading:new Transform(
              alignment: FractionalOffset.center,
              transform:new Matrix4.rotationZ(iconRotation*pi/180),
              child: new Container(
                height:80.0,
                width:20.0,
                alignment: Alignment.center,
                key: iconKey,
                child:new Icon(Icons.rotate_right,color:Colors.teal,size:40.0,),
              ),
            ),
            title:new Text(itemData.name,
              style:new TextStyle(
                fontSize: 32.0,
                color: Colors.teal,
              )),
            onTap:(){
              animateIcon();
            }
        )
    );
  }

  void animateIcon(){
    var controller = AnimationController(
        duration:new Duration(milliseconds: 1000),
        vsync:this
    );
    animation = new Tween(begin:0.0,end:1.0)
      .animate(controller)
      ..addListener((){
        setState((){
          this.iconRotation = animation.value*360;
        });
      });
    controller.forward();
  }
}