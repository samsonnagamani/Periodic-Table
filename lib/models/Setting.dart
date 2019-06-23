import 'dart:convert';
import 'dart:io';

class mSetting {
  var level;

  mSetting({this.level});

  factory mSetting.fromJson(Map<String, dynamic> json) {
    return mSetting(
      level : json["level"]
    );
  }

  static File getSettingsFile() {
    return File('../../assets/settings.json');
  }

  static setLevel(String level) {
    final file = getSettingsFile();



    print(file.readAsLines(encoding: utf8));
  }
}