import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testflutter/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/models/models.dart';
import 'package:testflutter/screens/loginpages.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class SettingPages extends StatefulWidget {
  const SettingPages({super.key});

  @override
  State<SettingPages> createState() => _SettingPagesState();
}

TextEditingController getfirstname = TextEditingController();
TextEditingController getlastname = TextEditingController();
TextEditingController getemail = TextEditingController();
TextEditingController gettell = TextEditingController();

TextEditingController enterfirstname = TextEditingController();
TextEditingController enterpassword = TextEditingController();
TextEditingController enterlastname = TextEditingController();
TextEditingController enteremail = TextEditingController();
TextEditingController entertell = TextEditingController();

class _SettingPagesState extends State<SettingPages> {
  late SharedPreferences prefs;

  late GetMelogin getMelogin;

  bool isLoading = false;
// error msg?
  String errorMsg = "";

  Future<GetMelogin> getDataFromApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');
    Uri url = Uri.parse('http://202.44.35.76:9091/api/me');

    var response = await http.get(url, headers: {'X-Token': '$token'});

    if (response.statusCode == HttpStatus.ok) {
      //ok
      GetMelogin getme = getMeloginFromJson(response.body);
      return getme;
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
      return GetMelogin(
          id: 0,
          active: false,
          firstName: "",
          lastName: "",
          tel: "",
          password: "",
          email: "");
    }
  }

  assignData() async {
    getMelogin = await getDataFromApi();
    setState(() {
      isLoading = true;
      ConvertdatatoTextfiled();
    });
  }

  initSaredPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // print(prefs.get('X-Token'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSaredPreferences();
    assignData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          'Lock out',
          style: TextStyle(fontSize: 15),
        ),
        icon: const FaIcon(FontAwesomeIcons.rightToBracket),
        backgroundColor: const Color(0xFFFE4A49),
        onPressed: () {
          prefs.remove('X-Token');
          // print(prefs.getString('X-Token'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPages()),
          );
        },
      ),
      appBar: SKAppBar(
        title: "All Setting",
        onPressed: () {
          Navigator.pop(context);
        },
        subtitle: "Setting MQTT Server and Account",
        haveleading: false,
        havetactions: false,
      ),
      body: !isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMsg.isNotEmpty
              ? const Center(
                  child: Text(
                  "error",
                  style: TextStyle(
                      fontSize: 25,
                      color: Color.fromARGB(255, 255, 17, 0),
                      fontWeight: FontWeight.bold),
                ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: height / 4,
                              width: width / 1.5,
                              // color: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Icon(
                                Icons.person,
                                size: 150,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          // color: Colors.green,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ExpansionTile(
                                  title: const Text(
                                    "Account Setting",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  leading: const Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  trailing: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ), //add icon
                                  childrenPadding: const EdgeInsets.only(
                                      left: 2), //children padding
                                  children: [
                                    SizedBox(
                                      height: height / 60,
                                    ),
                                    TextField(
                                        controller: getfirstname,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        decoration: const InputDecoration(
                                            labelText: 'First Name',
                                            border: OutlineInputBorder(),
                                            focusColor: Colors.white)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: getlastname,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        labelText: "Last Name",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: getemail,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        labelText: "E-Mail",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: gettell,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        labelText: "Tel",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: height / 11,
                                          child: OutlinedButton(
                                            onPressed: summitupdateData,
                                            child: const Text(
                                              'Confirmed',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: ExpansionTile(
                                      title: const Text(
                                        "Create Account ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      leading: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      trailing: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ), //add icon
                                      childrenPadding: const EdgeInsets.only(
                                          left: 2), //children padding
                                      children: [
                                        SizedBox(
                                          height: height / 60,
                                        ),
                                        TextField(
                                            controller: enteremail,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                                labelText: 'Email',
                                                border: OutlineInputBorder(),
                                                focusColor: Colors.white)),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: enterpassword,
                                          obscureText: true,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelText: "Password",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: enterfirstname,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelText: "First Name",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: enterlastname,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelText: "Last Name",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: entertell,
                                          style: const TextStyle(
                                              color: Colors.white),
                                          decoration: const InputDecoration(
                                            labelText: "Tell",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(),
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              height: height / 11,
                                              child: OutlinedButton(
                                                onPressed: submitPostdata,
                                                child: const Text(
                                                  'Create',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height / 15,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height / 15,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height / 7,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Future<void> summitupdateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');

    final body = {
      "first_name": getfirstname.text,
      "last_name": getlastname.text,
      "tel": gettell.text,
      "email": getemail.text
    };

    // call api post method
    Uri url = Uri.parse(
        "http://202.44.35.76:9091/api/dashboard/users/edit/${getMelogin.id}");
    var response = await http
        .put(url, body: jsonEncode(body), headers: {'X-Token': '$token'});

    // print(response.statusCode);
    // print(response.body);

    // if success
    if (response.statusCode == 200) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Update user success',
      );
    } else {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please check you server',
      );
    }
  }

  ConvertdatatoTextfiled() {
    getfirstname.text = getMelogin.firstName;
    getlastname.text = getMelogin.lastName;
    getemail.text = getMelogin.email;
    gettell.text = getMelogin.tel;
  }

  Future<void> submitPostdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');

    if (enteremail.text.isEmpty ||
        enterpassword.text.isEmpty ||
        enterfirstname.text.isEmpty ||
        enterlastname.text.isEmpty ||
        entertell.text.isEmpty) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please Input Data',
      );
    }

    // set data for api body

    final body = {
      "active": true,
      "first_name": enterfirstname.text,
      "last_name": enterlastname.text,
      "tel": entertell.text,
      "password": enterpassword.text,
      "email": enteremail.text
    };

    // call api post method
    Uri url = Uri.parse("http://202.44.35.76:9091/api/dashboard/users/new");
    var response = await http
        .post(url, body: jsonEncode(body), headers: {'X-Token': '$token'});

    // if success
    if (response.statusCode == 200) {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Create success',
      );
    } else {
      return QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oopss...',
        text: 'Please check you server',
      );
    }
  }
}
