import 'package:flutter/material.dart';
import 'package:globo_fitness/screens/intro_screen.dart';

void main() {
  runApp(const GlobeApp());
}

class GlobeApp extends StatelessWidget {
  const GlobeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const IntroScreen(),
      theme: ThemeData(primarySwatch: Colors.blueGrey),
    );
  }
}
