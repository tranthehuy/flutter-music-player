import 'package:flutter/material.dart';
import 'package:play_music/pages/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _configure();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Loading...',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.lightGreenAccent,
                  decoration: TextDecoration.none))
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage('assets/bg1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void startApp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Music Player')),
    );
  }

  Future<void> _configure() async {
    Future.delayed(const Duration(seconds: 2)).then((value) => startApp());
  }
}
