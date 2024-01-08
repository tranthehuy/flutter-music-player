import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:play_music/utils/configs.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../components/files.dart';

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  PlayerState? mode = null;
  PlatformFile? file;
  String? filePath;
  String fileName = '';
  bool repeat = false;
  AudioPlayer? audioPlayer;

  int length = 0;
  int current = 0;

  @override
  void initState() {
    super.initState();
    loadSettings();
    audioPlayer = AudioPlayer();
    audioPlayer!.onPlayerStateChanged.listen((PlayerState s) => {
          setState(() {
            mode = s;
          })
        });
    audioPlayer!.onDurationChanged.listen((Duration d) => {
          setState(() {
            length = d.inSeconds;
          })
        });
    audioPlayer!.onPositionChanged.listen((Duration p) => {
          setState(() {
            current = p.inSeconds;
          })
        });
  }

  Future<void> playAudio(String filePath) async {
    audioPlayer!.play(DeviceFileSource(filePath));
  }

  void updateLoop() {
    if (repeat && (audioPlayer != null)) {
      audioPlayer!.setReleaseMode(ReleaseMode.loop);
    } else {
      audioPlayer!.setReleaseMode(ReleaseMode.release);
    }
  }

  void loadSettings() async {
    await Fluttertoast.showToast(
        msg: "Load app config...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    final c = await Config.loadConfig();

    setState(() {
      if (c != null) {
        filePath = c.lastFile;
        fileName = c.lastFile.split('/').last;
        repeat = c.repeat;
        updateLoop();
        print(c.lastFile);
      }
    });
  }

  Future<void> saveSettings(String newFilePath, bool repeat) async {
    final c = Config(newFilePath, repeat);
    await Config.saveConfig(c);
  }

  void openFile() async {
    final selected = await FileHandler.chooseFile();
    if (selected == null) return;

    String newFilePath = selected!.path ?? '';

    await saveSettings(newFilePath, repeat);

    setState(() {
      file = selected!;
      final str = selected!.path ?? '';
      filePath = str;
      fileName = str.split('/').last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white12),
                    fixedSize: MaterialStateProperty.all(Size(70, 70)),
                  ),
                  onPressed: () {
                    loadSettings();
                  },
                  child: Icon(Icons.settings)),
              ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white12),
                    fixedSize: MaterialStateProperty.all(Size(70, 70)),
                  ),
                  onPressed: () {
                    openFile();
                  },
                  child: Icon(Icons.file_open)),
              ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: repeat
                        ? MaterialStateProperty.all<Color>(Colors.orange)
                        : MaterialStateProperty.all<Color>(Colors.white12),
                    fixedSize: MaterialStateProperty.all(Size(70, 70)),
                  ),
                  onPressed: () {
                    setState(() {
                      repeat = !repeat;
                      saveSettings(filePath!, repeat);
                      updateLoop();
                    });
                  },
                  child: Icon(Icons.repeat)),
            ],
          ),
        ),
        Container(
          color: Colors.white54,
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 100, 10, 100),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Flexible(
                    child: Text(
                  fileName,
                  style:
                      TextStyle(fontSize: 24, color: Colors.black),
                ))
              ])),
        ),
        LinearProgressIndicator(
          value: length != 0 ? current / length : 1,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      fixedSize: MaterialStateProperty.all(Size(70, 70)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)))),
                  onPressed: () {
                    audioPlayer!.pause();
                  },
                  child: Icon(Icons.pause)),
              Padding(padding: EdgeInsets.all(2)),
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: mode != null && mode!.name == 'playing'
                          ? MaterialStateProperty.all<Color>(Colors.white60)
                          : MaterialStateProperty.all<Color>(Colors.blue),
                      fixedSize: MaterialStateProperty.all<Size>(Size(80, 80)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)))),
                  onPressed: () {
                    if (filePath != null) {
                      playAudio(filePath!);
                    }
                  },
                  child: Icon(Icons.play_arrow)),
              Padding(padding: EdgeInsets.all(2)),
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      fixedSize: MaterialStateProperty.all<Size>(Size(70, 70)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)))),
                  onPressed: () {
                    audioPlayer!.stop();
                  },
                  child: Icon(Icons.stop))
            ],
          ),
        ),
      ],
    );
  }
}
