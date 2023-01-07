import 'package:flutter/material.dart';
import 'package:testflutter/screens/screens.dart';

void main() {
  runApp(const SKAPP());
}

class SKAPP extends StatelessWidget {
  const SKAPP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SK Mobile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IndexScreen(),
    );
  }
}
