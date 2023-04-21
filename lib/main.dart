import 'package:flutter/material.dart';
import 'package:testflutter/screens/loginpages.dart';
import 'package:testflutter/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("X-Token");
  print(token);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: token == null ? LoginPages() : IndexScreen(),
  ));
}
