import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'models/Element.dart';
import './elementScreen.dart';
import './loadScreen.dart';
import 'models/grid.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Periodic Table',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.level}) : super(key: key);
  final String title;
  final String level;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<mElement> elements = [];

  Future<String> loadElementFromAssets() async {
    return await rootBundle.loadString('assets/pTable.json');
  }

  Future loadElement() async {
    String jsonString = await loadElementFromAssets();
    final jsonRes = json.decode(jsonString);

    for (int i = 0; i < jsonRes.length; i++) {
      mElement element = new mElement.fromJson(jsonRes[i]);

      elements.add(element);
    }

    return elements;
  }

  Widget buildGameBody() {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Periodic Table')),
        ),
        body: Column(children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFF121212),
              child: OrientationBuilder(builder: (context, orientation) {
                return Stack(
                  children: <Widget>[
//                    TODO create period and group axis
                    GridView.builder(
                      scrollDirection: orientation == Orientation.portrait
                          ? Axis.horizontal
                          : Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: orientation == Orientation.portrait
                            ? grid.length
                            : grid[0].length,
                      ),
                      itemBuilder: buildGridItems,
                      itemCount: grid.length * grid[0].length,
                    ),
                  ],
                );
              }),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildGridItems(BuildContext context, int index) {
    int x, y;

    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      y = (index / grid.length).floor();
      x = (index % grid.length);
    } else if (orientation == Orientation.landscape) {
      y = (index % grid[0].length);
      x = (index / grid[0].length).floor();
    }

    var gridItem = buildGridItem(x, y);

    return GestureDetector(
      onTap: grid[x][y] == '#'
          ? null
          : () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        elementScreen(x, y, elements, widget.level)),
              ),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.025)),
          child: SizedBox(
            height: 50,
            width: 50,
            child: gridItem,
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(int x, int y) {
    Orientation orientation = MediaQuery.of(context).orientation;

    Widget tile;

    if (orientation == Orientation.portrait) {
      for (var el in elements) {
        if (grid[x][y] == el.number.toString()) {
          tile = Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: mElement.getColorByElCat(el, elements),
              width: 1,
            ))),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 2,
                  left: 2,
                  child: Text(
                    el.number.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: Text(
                    el.symbol,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: Text(
                    el.name,
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                )
              ],
            ),
          );
        } else if (grid[x][y] == '#') {
          tile = Container(
            color: Color(0xFF222222),
          );
        }
      }
    } else {
      for (var el in elements) {
        if (grid[x][y] == el.number.toString()) {
          tile = Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: mElement.getColorByElCat(el, elements),
              width: 0.5,
            ))),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 1,
                  left: 1,
                  child: Text(
                    el.number.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                ),
                Positioned(
                  top: 15,
                  child: Text(
                    el.symbol,
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ],
            ),
          );
        } else if (grid[x][y] == '#') {
          tile = Container(
            color: Color(0xFF222222),
          );
        }
      }
    }
    return tile;
  }

  @override
  void initState() {
    super.initState();
    loadElement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGameBody(),
    );
  }
}
