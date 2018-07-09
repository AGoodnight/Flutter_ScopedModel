import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app_scoped_model/app/app.dart';
import 'package:flutter_app_scoped_model/app_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<AppModel>(
      model: new AppModel(),
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new ScopedModelDescendant<AppModel>(
          builder: (context, child, model) =>
          new MyHomePage(
              title: 'Flutter Demo Home Page',
          ),
        ),
      ),
    );
  }
}