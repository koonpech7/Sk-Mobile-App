import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testflutter/components/appbar.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:testflutter/models/models.dart';

import 'package:http/http.dart' as http;
import 'package:testflutter/screens/screens.dart';

class IndexroomsScreens extends StatefulWidget {
  const IndexroomsScreens({super.key});

  @override
  State<IndexroomsScreens> createState() => _IndexroomsScreensState();
}

class _IndexroomsScreensState extends State<IndexroomsScreens> {
  late AllRoomsModels allrooms;
  // isLoading ?
  bool isLoading = false;
  // error msg?
  String errorMsg = "";

  int pages = 0;

  //Api Call

  Future<AllRoomsModels> getDataFromApi() async {
    Uri url = Uri.parse("http://202.44.35.76:9091/api/rooms?page=${pages}");
    var response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      //ok
      AllRoomsModels allroom = allRoomsModelsFromJson(response.body);
      return allroom;
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
      return AllRoomsModels(item: [], page: 0, totalCount: 0, totalPages: 0);
    }
  }

  assignData() async {
    try {
      allrooms = await getDataFromApi();
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
                : allrooms.item.isEmpty
                    ? const Text("No data")
                    : ListView.builder(
                        padding: const EdgeInsets.all(20.0),
                        itemCount: allrooms.item.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetSingleRoom(
                                            index: allrooms.item[index].id,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: SizedBox(
                                height: height / 7.5,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
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
                                        allrooms.item[index].label,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          const Text("Status   ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          Text("${allrooms.item[index].active}",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 4, 236, 11),
                                                  fontWeight: FontWeight.bold))
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
                                                          index: allrooms
                                                              .item[index].id,
                                                        )));
                                          },
                                          icon: const Icon(
                                              FontAwesomeIcons.rightToBracket),
                                          iconSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ));
  }
}
