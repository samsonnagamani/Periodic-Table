import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periodicTable/bloc/bloc.dart';
import 'package:periodicTable/main.dart';
import 'package:periodicTable/models/Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/level_bloc.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LevelBloc>(
      builder: (context) => LevelBloc(),
      child: LoadPage(),
    );
  }
}

class LoadPage extends StatelessWidget {
  IconData arrowRight =
      IconData(0xe5df, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  Widget build(BuildContext context) {
    final LevelBloc levelBloc = BlocProvider.of<LevelBloc>(context);

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Scaffold(
            appBar: AppBar(
                title: Container(
              alignment: Alignment.center,
              child: Text('Periodic Table'),
            )),
            body: BlocBuilder<LevelBloc, dynamic>(builder: (context, level) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                color: Color(0xFF111111),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Select Level',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    RaisedButton(
                      child: Text(
                        'A-Level',
                        style: TextStyle(color: Colors.white),
                      ),
                      color:
                          level == 'A-Level' ? Colors.green : Color(0xFF222222),
                      onPressed: () {
                        levelBloc.dispatch(LevelEvent.alevel);
                        print(level);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    RaisedButton(
                      child: Text(
                        'GCSE',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: level == 'GCSE' ? Colors.green : Color(0xFF222222),
                      onPressed: () {
                        levelBloc.dispatch(LevelEvent.gcse);
                        print(level);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      child: Icon(arrowRight),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                  title: 'Periodic Table',
                                  level: level,
                                )),
                      ),
                    ),
                  ],
                ),
              );
            })));
  }
}
