import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Config {
  String lastFile;
  bool repeat;

  Config(this.lastFile, this.repeat);

  Map<String, dynamic> toJson() => {
    'lastFile': lastFile,
    'repeat': repeat
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
      return Config(json['lastFile'], json['repeat']);
    } catch(e) {
      return null;
    }
  }
}