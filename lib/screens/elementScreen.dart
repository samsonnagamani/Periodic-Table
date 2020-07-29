import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:PeriodicTable/models/Element.dart';

class ElementScreen extends StatefulWidget {
  const ElementScreen({Key key, @required this.element, @required this.level})
      : super(key: key);

  final mElement element;
  final String level;

  @override
  _ElementScreenState createState() => _ElementScreenState();
}

class _ElementScreenState extends State<ElementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: OrientationBuilder(builder: (context, orientation) {
        return Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TopBar(widget.element),
            ),
            Expanded(
                flex: orientation == Orientation.portrait ? 3 : 2,
                child: ElementPageContent(widget.element, widget.level)),
          ],
        );
      }),
    ));
  }
}

class TopBar extends StatelessWidget {
  final mElement el;

  TopBar(this.el);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
        color: Colors.deepPurple,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: mElement.getColorByElCat(el), width: 1)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
            ),
            Center(
              child: typeOfElement(el, size),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
            ),
            Text(
              el.name,
              style: TextStyle(fontSize: 25.0, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
            ),
            orientation == Orientation.portrait
                ? Text(
                    '${el.atomicMass.toString()} (g/mol)',
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  )
                : Spacer(
                    flex: 1,
                  )
          ],
        ));
  }

  Widget typeOfElement(el, size) {
    return PlayAnimation(
      duration: Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, opacityValue, value) {
        return Opacity(
            opacity: value,
            child: textBox(el.category.toUpperCase(), 28, size.width / 1.5,
                Alignment.center, mElement.getColorByElCat(el)));
      },
    );
  }
}

class ElementPageContent extends StatefulWidget {
  final mElement el;
  final String level;

  ElementPageContent(this.el, this.level);

  @override
  _ElementPageContentState createState() => _ElementPageContentState();
}

class _ElementPageContentState extends State<ElementPageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: widget.level == 'GCSE'
            ? gcseData(widget.el)
            : alevelData(widget.el),
        scrollDirection: Axis.vertical,
      ),
    );
  }

  List<Widget> gcseData(mElement el) {
    return <Widget>[
      elementInfoTile('Overview'),
      elementInfoTile('Name', el.name, Icons.label_important, el.category),
      elementInfoTile('Atomic Number', el.number.toString()),
      elementInfoTile('Atomic Mass', el.atomicMass.toString()),
      elementInfoTile('Ion Charge', mElement.getIonicChargeAsString(el)),
    ];
  }

  List<Widget> alevelData(mElement el) {
    return <Widget>[
      elementInfoTile('Overview'),
      elementInfoTile('Name', el.name, Icons.label_important, el.category),
      elementInfoTile('Atomic Number', el.number.toString()),
      elementInfoTile('Atomic Mass', el.atomicMass.toString()),
      elementInfoTile('Ion Charge', mElement.getIonicChargeAsString(el)),
      elementInfoTile('Electron Configuration', el.electronConfigSemantic, null,
          null, 'View full', el.electronConfig, 'View Less'),
      // elementInfoTile('Electron Configuration',
      //     mElement.getAbbreviatedElectronConfig(elements, el)),
    ];
  }
}

class elementInfoTile extends StatefulWidget {
  final String name;
  String value;
  final IconData icon;
  final String category;
  String buttonForwardText;
  final String buttonReturn;
  final String buttonBackwardText;

  elementInfoTile(this.name,
      [this.value = '',
      this.icon,
      this.category,
      this.buttonForwardText,
      this.buttonReturn,
      this.buttonBackwardText]);

  @override
  _elementInfoTileState createState() => _elementInfoTileState();
}

class _elementInfoTileState extends State<elementInfoTile> {
  bool isButtonOpen = false;
  String tempForwardText;
  String tempBackwardText;
  String tempTileValue;
  String tempButtonReturn;

  @override
  void initState() {
    super.initState();
    tempForwardText = widget.buttonForwardText;
    tempBackwardText = widget.buttonBackwardText;
    tempTileValue = widget.value;
    tempButtonReturn = widget.buttonReturn;
  }

  @override
  Widget build(BuildContext context) {
    void buttonForwardAction() {
      print(tempTileValue);
      setState(() {
        isButtonOpen = !isButtonOpen;
        widget.value = tempButtonReturn;
        widget.buttonForwardText = tempBackwardText;
      });
    }

    void buttonBackwardAction() {
      print(isButtonOpen);
      print(tempTileValue);
      setState(() {
        isButtonOpen = !isButtonOpen;
        widget.value = tempTileValue;
        widget.buttonForwardText = tempForwardText;
      });
    }

    return ListTile(
      leading: Icon(
        widget.icon,
        color: widget.category != null
            ? mElement.getColorByElCat(null, widget.category)
            : Colors.white,
      ),
      trailing: widget.buttonForwardText != null
          ? OutlineButton(
              child: Text(widget.buttonForwardText),
              borderSide: BorderSide(color: Colors.amber, width: 1),
              textColor: Colors.white,
              onPressed: () {
                isButtonOpen ? buttonBackwardAction() : buttonForwardAction();
              },
            )
          : Text('123'),
      title: Text(
        widget.name,
        style: TextStyle(color: Colors.amber),
      ),
      subtitle: Text(
        widget.value,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

// Widget elementInfoTile(String name,
//     [String value = '',
//     IconData icon,
//     String category,
//     String buttonText,
//     String buttonReturn]) {

// }

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
