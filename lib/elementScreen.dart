import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/Element.dart';
import 'package:simple_animations/simple_animations.dart';
import 'models/grid.dart';

elementScreen(int x, int y, List<mElement> elements, String level) {
  for (var el in elements) {
    if (grid[x][y] == el.number.toString()) {
      return Scaffold(
          body: Container(
              child: Column(
        children: <Widget>[
          topBar(el, elements),
          ElementPageContent(el, level),
        ],
      )));
    }
  }
}

topBar(var el, List<mElement> elements) {
  return OrientationBuilder(
    builder: (context, orientation) {
      return SizedBox(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            GreyBar(el, elements),
            CircleAvatar(el, elements),
          ],
        ),
      );
    },
  );
}

class GreyBar extends StatelessWidget {
  final el;
  final List<mElement> elements;

  GreyBar(this.el, this.elements);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return ControlledAnimation(
      duration: Duration(milliseconds: 400),
      tween: Tween<double>(begin: 0, end: 210),
      builder: (context, animation) {
        return Container(
          constraints: orientation == Orientation.portrait
              ? BoxConstraints(maxWidth: double.infinity, minHeight: 210)
              : BoxConstraints(maxWidth: double.infinity, minHeight: 100),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: mElement.getColorByElCat(el, elements), width: 1)),
              color: Color(0xFF333333)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(IconData(0xe5e0,
                          fontFamily: 'MaterialIcons',
                          matchTextDirection: true)),
                      color: Colors.white,
                    ),
                    typeOfElement(el, size),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
              ),
              Text(
                el.name,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
              ),
              Text(
                '${el.atomicMass.toString()} (g/mol)',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              )
            ],
          ),
        );
      },
    );
  }

  Widget typeOfElement(el, size) {
    return ControlledAnimation(
      duration: Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacityValue) {
        return Opacity(
            opacity: opacityValue,
            child: textBox(el.category.toUpperCase(), 28, size.width / 1.5,
                Alignment.center, mElement.getColorByElCat(el, elements)));
      },
    );
  }
}

class CircleAvatar extends StatelessWidget {
  final el;
  final elements;

  CircleAvatar(this.el, this.elements);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return ControlledAnimation(
      duration: Duration(milliseconds: 600),
      delay: Duration(milliseconds: (300 * 2).round()),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, scaleValue) {
        return Positioned(
          top: orientation == Orientation.portrait ? 160 : 80,
          left: orientation == Orientation.portrait
              ? size.width / 2 - 50
              : size.width / 2 + 150,
          child: Transform.scale(
            scale: scaleValue,
            alignment: Alignment.center,
            child: greyCircle(context, el, elements),
          ),
        );
      },
    );
  }

  Widget greyCircle(BuildContext context, var el, List elements) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: orientation == Orientation.portrait ? 100 : 75,
      width: orientation == Orientation.portrait ? 100 : 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: mElement.getColorByElCat(el, elements),
      ),
      child: Center(
          child: Text(
        el.symbol,
        style: TextStyle(
          color: Colors.white,
          fontSize: orientation == Orientation.portrait ? 40 : 30,
        ),
      )),
    );
  }
}

class ElementPageContent extends StatelessWidget {
  final el;
  final level;

  ElementPageContent(this.el, this.level);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: infoList(el),
    );
  }

  Widget infoList(el) {
    return Ink(
      color: Color(0xFF111111),
      child: ListView(
        children: level == 'GCSE'
            ? <Widget>[
                ListTile(
                  title: Text(
                    'Overview',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Name',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Atomic Number',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.number.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Atomic Mass',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.atomicMass.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Phase',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.phase,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Ion Charge',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    mElement.getIonicChargeAsString(el),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]
            : <Widget>[
                ListTile(
                  title: Text(
                    'Overview',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Name',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.name,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Discovered By',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.discoveredBy,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Atomic Number',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.number.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Atomic Mass',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.atomicMass.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Phase',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    el.phase,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Ion Charge',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    mElement.getIonicChargeAsString(el),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

Widget textBox(String text, double height, double width, Alignment alignment,
    Color bColor) {
  return Align(
    alignment: alignment,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bColor,
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      )),
    ),
  );
}
