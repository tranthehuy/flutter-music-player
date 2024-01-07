import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Config {
  String name;

  Config(this.name);

  Map<String, dynamic> toJson() => {
    'name': name
  };

  static Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path + '/config.json';
    return path;
  }

  static Future<void> saveConfig(Config config) async {
    final file = File(await getLocalPath());
    await file.writeAsString(jsonEncode(config.toJson()));
  }

  static Future<Config?> loadConfig() async {
    try {
      final file = File(await getLocalPath());
      final contents = await file.readAsString();
      final json = jsonDecode(contents);
      return Config(json['name']);
    } catch(e) {
      return null;
    }
  }
}