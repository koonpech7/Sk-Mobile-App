import 'dart:io';

import 'package:flutter/material.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testflutter/models/models.dart';

import 'package:http/http.dart' as http;
import 'package:testflutter/screens/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // response
  late NotificationLog notificationsLog;
  // isLoading ?
  bool isLoading = false;
  // error msg?
  String errorMsg = "";

  int pages = 1;

  //Api Call

  Future<NotificationLog> getDataFromApi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('X-Token');
    Uri url =
        Uri.parse("http://202.44.35.76:9091/api/dashboard/reports?page=$pages");
    var response = await http.get(url, headers: {'X-Token': token!});

    // print(token);

    if (response.statusCode == HttpStatus.ok) {
      //ok
      NotificationLog notilog = notificationFromJson(response.body);
      return notilog;
    } else {
      errorMsg = "${response.statusCode}: ${response.body}";
      return NotificationLog(items: [], page: 0, totalCount: 0, totalPages: 0);
    }
  }

  assignData() async {
    try {
      notificationsLog = await getDataFromApi();
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
          title: "Notifications",
          onPressed: () {
            Navigator.pop(context);
          },
          subtitle: "Log Change Status ",
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : notificationsLog.items.isEmpty
                    ? const Center(
                        child: Text(
                        "No data",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ))
                    : ListView.builder(
                        padding: const EdgeInsets.all(20.0),
                        itemCount: notificationsLog.items.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              // print(notificationsLog.items[index].id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GetSingelNoti(
                                            index: notificationsLog
                                                .items[index].id,
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
                                        notificationsLog.items[index].roomLabel,
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
                                          Text(
                                              notificationsLog
                                                  .items[index].status,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 4, 236, 11),
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),

                                      trailing: Column(
                                        children: [
                                          Text(
                                            notificationsLog
                                                .items[index].reportTime,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: height / 90,
                                          ),
                                          Text(
                                            notificationsLog
                                                .items[index].reportDate,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      // trailing: Text(
                                      //   notificationsLog
                                      //       .items[index].reportTime,
                                      //   style: const TextStyle(
                                      //       fontSize: 20,
                                      //       fontWeight: FontWeight.bold,
                                      //       color: Color.fromARGB(
                                      //           255, 163, 162, 162)),
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })));
  }

  // Widget getMyrow(int index) {
  //   return GestureDetector(
  //     onTap: () {},
  //     child: Padding(
  //       padding: const EdgeInsets.all(2.0),
  //       child: SizedBox(
  //         height: 60,
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(20),
  //           ),
  //           elevation: 0,
  //           color: const Color(0xFF2F2F42),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 20),
  //             child: ListTile(
  //               contentPadding: const EdgeInsets.symmetric(vertical: 10),
  //               title: Text(
  //                 notilog.items[index].roomLabel,
  //                 style: const TextStyle(
  //                     fontSize: 25,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white),
  //               ),
  //               subtitle: Text(
  //                 "${notilog.items[index].personCount}",
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                 ),
  //               ),
  //               trailing: Text(
  //                 notilog.items[index].reportTime,
  //                 style: const TextStyle(
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
}

// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: SizedBox(
//           height: height / 0.8,
//           child: ListView.builder(
//             // physics: const NeverScrollableScrollPhysics(),
//             itemCount: notification.length,
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {},
//                 child: Padding(
//                   padding: const EdgeInsets.all(2.0),
//                   child: SizedBox(
//                     height: height / 7.5,
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       elevation: 0,
//                       color: const Color(0xFF2F2F42),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: ListTile(
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 10),
//                           title: Text(
//                             "${notification[index].name}",
//                             style: const TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                           subtitle: Text(
//                             notification[index].status! ? "close" : "open",
//                             style: TextStyle(
//                               fontSize: 15,
//                               color: notification[index].status!
//                                   ? const Color(0xFFFF0505)
//                                   : const Color(0xFF05FF3C),
//                             ),
//                           ),
//                           trailing: Text(
//                             "${notification[index].time}",
//                             style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
