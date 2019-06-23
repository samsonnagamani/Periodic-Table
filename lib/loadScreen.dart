import 'package:periodicTable/main.dart';
import 'package:periodicTable/models/Setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoadScreenState();
}

class LoadScreenState extends State<LoadScreen> {
//  List<mSetting> settings = [];
//
//  Future<String> getSettingsFromFile() async {
//    return await rootBundle.loadString('assets/settings.json');
//  }
//
//  Future getLevelState() async {
//    var jsonSettings = await getSettingsFromFile();
//    final jsonRes = json.decode(jsonSettings);
//
//    for (int i = 0; i < jsonRes.length; i++) {
//      mSetting setting = new mSetting.fromJson(jsonRes[i]);
//
//      settings.add(setting);
//    }
//    print(settings[0].level);
//
//    return settings;
//  }

  var levelState;

  IconData arrow_right = IconData(0xe5df, fontFamily: 'MaterialIcons', matchTextDirection: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            child: Text('Periodic Table'),
          )
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFF111111),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Select Level', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              Padding(
                padding: EdgeInsets.all(20),
              ),
              RaisedButton(
                child: Text('A-Level', style: TextStyle(color: Colors.white),),
                color: levelState == 'A-Level' ? Colors.green : Color(0xFF222222),
                onPressed: () {
                  setState(() {
                    levelState = 'A-Level';
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                child: Text('GCSE', style: TextStyle(color: Colors.white),),
                color: levelState == 'GCSE' ? Colors.green : Color(0xFF222222),
                onPressed: () {
                  setState(() {
                    levelState = 'GCSE';
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(20),
              ),
              FloatingActionButton(
                backgroundColor: Colors.green,
                child: Icon(arrow_right),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(title: 'Periodic Table', level: levelState,)),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}