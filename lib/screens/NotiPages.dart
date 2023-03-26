import 'package:flutter/material.dart';
import 'package:testflutter/components/components.dart';
import 'package:testflutter/models/models.dart';

import 'package:http/http.dart' as http;

class NotiDetails extends StatelessWidget {
  const NotiDetails({super.key, required this.userPat});
  final Item userPat;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Notifications Detail",
        onPressed: () {
          Navigator.pop(context);
        },
        havetactions: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 27, 27, 39),
          ),
          height: height / 1.3,
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Room Number  ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(userPat.roomLabel,
                      textAlign: TextAlign.right,
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              SizedBox(
                height: height / 70,
              ),
              // Row(
              //   children: [
              //     const Text(
              //       "Person Count  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.personCount}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Computer Active  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.comOnCount}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Time  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.reportTime}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Date  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.reportDate}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Door  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.doorStatus}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Air Conditioner   ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.airStatus}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Lamp 1  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.lamp1Status}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Lamp 2  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.lamp2Status}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Lamp 3  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.lamp3Status}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Lamp 4  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.lamp4Status}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Lamp 5  ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.lamp5Status}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              // SizedBox(
              //   height: height / 55,
              // ),
              // Row(
              //   children: [
              //     const Text(
              //       "Lamp 6 ",
              //       style: TextStyle(fontSize: 18, color: Colors.white),
              //     ),
              //     const Spacer(),
              //     Text("${userPat.lamp6Status}",
              //         textAlign: TextAlign.right,
              //         style: const TextStyle(fontSize: 18, color: Colors.white))
              //   ],
              // ),
              Text("${userPat.image}")
            ],
          ),
        ),
      ),
    );
  }
}
