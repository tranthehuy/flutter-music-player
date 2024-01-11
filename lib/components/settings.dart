import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsDialog {
  late BuildContext context;
  SettingsDialog(this.context);

  void changeColor(Color color) {
    print(color);
  }

  Future<void> show() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('App Settings'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Background'),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  height: 50.0,
                  child: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (_, i) {
                          return GestureDetector(
                              onTap: () => {print('choose ' + i.toString())},
                              child: Container(
                                  margin: EdgeInsets.all(5),
                                  child: Image(
                                      image: AssetImage('assets/bg' +
                                          (i % 3 + 1).toString() +
                                          '.jpg')))
                          );
                        },
                      ))),
              Text('Text color'),
              SingleChildScrollView(
                  child: BlockPicker(
                pickerColor: Colors.green,
                onColorChanged: changeColor,
                availableColors: [
                  Colors.white,
                  Colors.red,
                  Colors.pink,
                  Colors.purple,
                  Colors.deepPurple,
                  Colors.indigo,
                  Colors.blue,
                  Colors.lightBlue,
                  Colors.cyan,
                  Colors.teal,
                  Colors.green,
                  Colors.lightGreen,
                  Colors.lime,
                  Colors.yellow,
                  Colors.amber,
                  Colors.orange,
                  Colors.deepOrange,
                  Colors.brown,
                  Colors.grey,
                  Colors.blueGrey,
                  Colors.black,
                ],
              )),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
