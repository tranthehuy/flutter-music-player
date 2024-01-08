import 'package:flutter/material.dart';
import 'package:play_music/pages/player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
        body:
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Player()
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: new AssetImage('assets/bg2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        )

    );
  }
}
