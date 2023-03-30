import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testflutter/MQTTClientManager.dart';
import 'package:testflutter/screens/screens.dart';
import 'package:testflutter/screens/index_room.dart';
import 'package:testflutter/screens/single_room.dart';
import 'package:testflutter/screens/user.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    IndexRoom(),
    NotificationScreen(),
    UserScreens()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.houseChimney), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bell), label: "Notifications"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.gear), label: "Account"),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Color(0xff1F1F39),
        selectedItemColor: Color(0xFF3D5CFF),
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
