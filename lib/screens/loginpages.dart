import 'dart:convert';

import 'package:flutter/material.dart';

// import api
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/screens/index.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  late SharedPreferences prefs;

  initSaredPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // print(prefs.get('X-Token'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSaredPreferences();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Icon(
              Icons.person,
              size: 130,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Welcome back you\'ve been missed!',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: height / 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  TextField(
                      autofocus: true,
                      controller: email,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(
                          color:
                              Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                      obscureText: true,
                      autofocus: true,
                      controller: password,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color:
                              Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      )),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.topRight,
                    height: height / 12,
                    width: width,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        onPressed: submittData,
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  submittData() async {
    if (email.text.isEmpty || password.text.isEmpty) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please Input Username and Password',
      );
    }
    final body = {"email": email.text, "password": password.text};
    var url = Uri.parse("http://202.44.35.76:9091/api/login");

    var response = await http.post(url, body: jsonEncode(body));
    if (response.statusCode == 200) {
      Map<String, dynamic> xToken = jsonDecode(response.body);
      prefs.setString("X-Token", xToken['access_token']);
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Welcome to SK Application',
        onConfirmBtnTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const IndexScreen()),
          );
        },
      );
    } else {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Username or Password is incorrect',
      );
    }
  }
}
