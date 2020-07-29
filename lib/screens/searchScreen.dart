import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:PeriodicTable/bloc/bloc.dart';
import 'package:PeriodicTable/components/SimpleAppBar.dart';
import 'package:PeriodicTable/models/Element.dart';
import 'package:PeriodicTable/screens/elementScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<String> loadElementsFromAssets() async {
  return await rootBundle.loadString('assets/pTable.json');
}

Future loadElements(List<mElement> list) async {
  String jsonString = await loadElementsFromAssets();
  final jsonRes = json.decode(jsonString);

  for (int i = 0; i < jsonRes.length; i++) {
    mElement element = new mElement.fromJson(jsonRes[i]);

    if (list.length == jsonRes.length) {
      return;
    }
    list.add(element);
  }
}

Future loadElementsInLists(List<List<mElement>> lists) async {
  for (List<mElement> list in lists) {
    await loadElements(list);
  }
}

List<mElement> elements = [];
List<mElement> duplicateElements = [];

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: FutureBuilder(
        future: loadElementsInLists([elements, duplicateElements]),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done
              ? Search()
              : Center(
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    child: CircularProgressIndicator(),
                  ),
                );
        },
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController elementTextField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlatButton(
          child: Text('Go to Grid'),
          onPressed: () => Navigator.pop(context),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.pink,
          ),
          height: 55,
          child: Padding(
            padding: EdgeInsets.all(3),
            child: TextField(
              controller: elementTextField,
              decoration: InputDecoration(
                  filled: true,
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ))),
              onChanged: (value) {
                value = value.toLowerCase();
                List<mElement> dummySearchList = [];
                dummySearchList.addAll(duplicateElements);
                if (value.isNotEmpty) {
                  List<mElement> dummyListData = List<mElement>();
                  dummySearchList.forEach((el) {
                    if (el.name.toLowerCase().contains(value) ||
                        el.symbol.toLowerCase().contains(value) ||
                        el.category.toLowerCase().contains(value)) {
                      dummyListData.add(el);
                    }
                  });
                  setState(() {
                    elements.clear();
                    elements.addAll(dummyListData);
                  });
                  return;
                } else {
                  setState(() {
                    elements.clear();
                    elements.addAll(duplicateElements);
                  });
                }
              },
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<LevelBloc, String>(
              builder: (BuildContext context, level) {
            return Container(
              color: Color(0xFF333333),
              child: ListView.builder(
                itemCount: elements.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  mElement element = elements[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.pink, width: 0.5)),
                    ),
                    child: ListTile(
                      title: Text(
                        element.name,
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(element.symbol),
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        child: Text(element.symbol),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ElementScreen(element: element, level: level);
                        }));
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
