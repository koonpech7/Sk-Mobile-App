import 'package:flutter/material.dart';
import 'package:testflutter/components/components.dart';

class SettingPages extends StatefulWidget {
  const SettingPages({super.key});

  @override
  State<SettingPages> createState() => _SettingPagesState();
}

class _SettingPagesState extends State<SettingPages> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "All Setting",
        onPressed: () {
          Navigator.pop(context);
        },
        subtitle: "Setting MQTT Server and Account",
        haveleading: false,
        havetactions: false,
      ),
      body: Padding(
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
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://ichef.bbci.co.uk/news/976/cpsprodpb/17638/production/_124800859_gettyimages-817514614.jpg.webp',
                      ),
                      radius: 80,
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
                        childrenPadding:
                            const EdgeInsets.only(left: 2), //children padding
                        children: [
                          SizedBox(
                            height: height / 60,
                          ),
                          const TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: 'Enter Name',
                                  border: OutlineInputBorder(),
                                  focusColor: Colors.white)),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: height / 11,
                                child: OutlinedButton(
                                  onPressed: () => {},
                                  child: const Text(
                                    'Clear Textfield',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: height / 11,
                                child: OutlinedButton(
                                  onPressed: () => {},
                                  child: const Text(
                                    'Confirmed',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ExpansionTile(
                        title: const Text(
                          "MQTT Setting",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        trailing: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ), //add icon
                        childrenPadding:
                            const EdgeInsets.only(left: 2), //children padding
                        children: [
                          SizedBox(
                            height: height / 60,
                          ),
                          const TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelText: "Set IP",
                                  border: OutlineInputBorder(),
                                  focusColor: Colors.white)),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Set Port",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Set Client Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Set Username",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: "Set Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: height / 11,
                                child: OutlinedButton(
                                  onPressed: () => {},
                                  child: const Text(
                                    'Clear Textfield',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: height / 11,
                                child: OutlinedButton(
                                  onPressed: () => {},
                                  child: const Text(
                                    'Confirmed',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
