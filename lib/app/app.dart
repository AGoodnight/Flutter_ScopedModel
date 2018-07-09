import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app_scoped_model/app_model.dart';
import 'package:flutter_app_scoped_model/app/custom_list.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(title),
//      ),
      body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                pinned: true,
                title: new Text('Flutter Demo'),
              ),
            ];
          },
          body: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newText(),
                counterButtons(),
                list(400.0)
              ]
          )
      ),
      floatingActionButton: cornerButton(),
    );
  }
}

var newText = () => ScopedModelDescendant<AppModel>(
    builder: (context, child, model) => new Text(
      '${model.counter.toString()} Likes',
      style: Theme.of(context).textTheme.display1,
    ),
);

var cornerButton = () => ScopedModelDescendant<AppModel>(
  builder:(context,child,model)=> new FloatingActionButton(
    onPressed: model.randomType,
    tooltip: 'Increment',
    child: new Icon(Icons.add),
  ), // This trailing comma makes auto-formatting nicer for build methods.
);

var counterButtons = () => ScopedModelDescendant<AppModel>(
  builder:(context,child,model)=> new ButtonBar(
    children:[
      new FlatButton.icon(onPressed: model.increment, icon: new Icon(Icons.thumb_up), label: new Text('Like')),
      new FlatButton.icon(onPressed: model.decrement, icon: new Icon(Icons.thumb_down), label: new Text('Dislike')),
      new FlatButton.icon(onPressed: model.reset, icon: new Icon(Icons.refresh), label: new Text('Reset')),
    ]
  ),
);

var list = (double height) => ScopedModelDescendant<AppModel>(
  builder: (context, child, model) => new CustomList(
    height:height,
    data:model.some
  ),
);