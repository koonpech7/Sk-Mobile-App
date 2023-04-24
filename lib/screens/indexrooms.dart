import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testflutter/components/appbar.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:testflutter/models/models.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:testflutter/screens/screens.dart';

import 'package:shared_preferences/shared_preferences.dart';

class IndexroomsScreens extends StatefulWidget {
  const IndexroomsScreens({super.key});

  @override
  State<IndexroomsScreens> createState() => _IndexroomsScreensState();
}

class _IndexroomsScreensState extends State<IndexroomsScreens> {
  List items = [];
  // late AllRoomsModels allrooms;
  // isLoading ?
  bool isLoading = false;
  // error msg?
  String errorMsg = "";

  int pages = 1;

  assignData() async {
    try {
      fethData();
    } on Exception catch (e) {
      // TODO
      print("error");
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // cal api
    assignData();
    // initSaredPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFF1F1F39),
        appBar: SKAppBar(
          title: "Select Rooms",
          subtitle: "Choice your rooms",
          onPressed: () {
            Navigator.pop(context);
          },
          haveleading: false,
          havetactions: false,
        ),
        body: !isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : errorMsg.isNotEmpty
                ? Center(
                    child: Text(
                      "Error $errorMsg",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 255, 17, 0),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : items.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: fethData,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20.0),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index] as Map;
                            return GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => GetSingleRoom(
                                  //               index: items[index].id,
                                  //             )));
                                },
                                child: Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        onPressed: (context) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateRooms(
                                                        index: item['id'],
                                                        roomsname:
                                                            item['label'],
                                                      )));
                                        },
                                        backgroundColor: const Color.fromARGB(
                                            255, 19, 112, 252),
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        label: 'Edit',
                                      ),
                                      SizedBox(width: width / 90),
                                      SlidableAction(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        onPressed: (context) async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          var token =
                                              prefs.getString('X-Token');
                                          Uri url = Uri.parse(
                                              "http://202.44.35.76:9091/api/dashboard/rooms/delete/${item['id']}");
                                          var response = await http.delete(url,
                                              headers: {'X-Token': '$token'});
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      height: height / 7.5,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        elevation: 0,
                                        color: const Color(0xFF2F2F42),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10),
                                            title: Text(
                                              item['label'],
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            subtitle: Row(
                                              children: const [
                                                Text("Status   ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text("Active",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromARGB(
                                                            255, 255, 255, 255),
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                            trailing: CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xFF69696F),
                                              radius: 30,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GetSingleRoom(
                                                                index:
                                                                    item['id'],
                                                              )));
                                                },
                                                icon: const Icon(
                                                    FontAwesomeIcons
                                                        .rightToBracket),
                                                iconSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        ),
                      ));
  }

  Future<void> fethData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');
    Uri url =
        Uri.parse("http://202.44.35.76:9091/api/dashboard/rooms?page=${pages}");
    var response = await http.get(url, headers: {'X-Token': '$token'});

    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'];
      setState(() {
        items = result;
      });
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
    }
  }

  // Future<void> deleteData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('X-Token');
  //   Uri url =
  //       Uri.parse("http://202.44.35.76:9091/api/dashboard/rooms?page=${pages}");
  //   var response = await http.delete(url, headers: {'X-Token': '$token'});
  // }
}
