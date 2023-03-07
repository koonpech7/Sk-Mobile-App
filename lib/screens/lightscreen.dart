import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testflutter/components/appbar.dart';

class LightScreens extends StatefulWidget {
  const LightScreens({super.key});

  @override
  State<LightScreens> createState() => _LightScreensState();
}

class _LightScreensState extends State<LightScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: const Color(0xFF1F1F39),
    appBar: SKAppBar(
        title: "Room 702",
        subtitle: "Choice your feature",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}