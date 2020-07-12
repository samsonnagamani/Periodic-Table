import 'package:PeriodicTable/components/SimpleAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PeriodicTable/bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:PeriodicTable/bloc/level_bloc.dart';
import 'package:PeriodicTable/screens/gridScreen.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LevelBloc>(create: (context) => LevelBloc()),
        BlocProvider<AnimationBloc>(create: (context) => AnimationBloc()),
      ],
      child: Builder(builder: (context) => LoadPage()),
    );
  }
}

class LoadPage extends StatelessWidget {
  final IconData arrowRight =
      IconData(0xe5df, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final LevelBloc levelBloc = BlocProvider.of<LevelBloc>(context);

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
            appBar: SimpleAppBar(),
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
                      color: level == 'A-Level'
                          ? Colors.deepPurple
                          : Color(0xFF222222),
                      onPressed: () {
                        levelBloc.add(LevelEvents.alevel);
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
                      color: level == 'GCSE'
                          ? Colors.deepPurple
                          : Color(0xFF222222),
                      onPressed: () {
                        levelBloc.add(LevelEvents.gcse);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(arrowRight),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GridScreen(
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
