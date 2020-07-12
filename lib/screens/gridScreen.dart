import 'package:PeriodicTable/components/SimpleAppBar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:PeriodicTable/models/Element.dart';
import 'package:PeriodicTable/models/grid.dart';
import 'package:PeriodicTable/screens/elementScreen.dart';
import 'package:PeriodicTable/components/Nav.dart';

class GridScreen extends StatefulWidget {
  GridScreen({Key key, this.title, this.level}) : super(key: key);
  final String title;
  final String level;

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: FutureBuilder(
        future: loadElements(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? buildGrid()
              : Center(
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
      floatingActionButton: Nav(),
    );
  }

  List<mElement> elements = [];

  Future<String> loadElementsFromAssets() async {
    return await rootBundle.loadString('assets/pTable.json');
  }

  Future loadElements() async {
    String jsonString = await loadElementsFromAssets();
    final jsonRes = json.decode(jsonString);

    for (int i = 0; i < jsonRes.length; i++) {
      mElement element = new mElement.fromJson(jsonRes[i]);

      elements.add(element);
    }

    return elements;
  }

  Widget buildGrid() {
    return SafeArea(
      child: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFF121212),
          child: OrientationBuilder(builder: (context, orientation) {
            return Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                FutureBuilder(
                  future: buildGridItems(context),
                  builder: (context, snapshot) {
                    return GridView.count(
                        scrollDirection: orientation == Orientation.portrait
                            ? Axis.horizontal
                            : Axis.vertical,
                        crossAxisCount: orientation == Orientation.portrait
                            ? grid.length
                            : grid[0].length,
                        children:
                            snapshot.connectionState == ConnectionState.done
                                ? snapshot.data
                                : <Widget>[
                                    Center(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  ]);
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Future<List<Widget>> buildGridItems(BuildContext context) async {
    List<Widget> gridItems = [];

    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.landscape) {
      for (var i = 0; i < grid.length; i++) {
        for (var j = 0; j < grid[0].length; j++) {
          await buildGridItem(i, j).then((item) => gridItems.add(item));
        }
      }
    }

    if (orientation == Orientation.portrait) {
      for (var i = 0; i < grid[0].length; i++) {
        for (var j = 0; j < grid.length; j++) {
          await buildGridItem(j, i).then((item) => gridItems.add(item));
        }
      }
    }

    return gridItems;
  }

  Future<Widget> buildGridItem(int x, int y) async {
    Orientation orientation = MediaQuery.of(context).orientation;

    Widget tile;

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
            overflow: Overflow.clip,
            children: <Widget>[
              Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    el.number.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.level == 'GCSE'
                        ? (el.symbol == 'Cl' || el.symbol == 'Cu')
                            ? el.atomicMass.toStringAsFixed(1)
                            : el.atomicMass.toStringAsFixed(0)
                        : el.atomicMass.toStringAsFixed(1),
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    orientation != Orientation.landscape
                        ? Text(
                            el.symbol,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        : Text(
                            el.symbol,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                    orientation != Orientation.landscape
                        ? Text(
                            el.name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 9.0),
                          )
                        : SizedBox()
                  ],
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

    return GestureDetector(
        onTap: grid[x][y] == '#'
            ? null
            : () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        elementScreen(x, y, elements, widget.level))),
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.025)),
            child: SizedBox(
              height: 50,
              width: 50,
              child: tile,
            ),
          ),
        ));
  }
}
