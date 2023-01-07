import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:testflutter/screens/single_room.dart';

class IndexRoom extends StatefulWidget {
  const IndexRoom({super.key});

  @override
  State<IndexRoom> createState() => _IndexRoomState();
}

class _IndexRoomState extends State<IndexRoom> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Rooms",
        subtitle: "all active rooms",
        onPressed: () {
          Navigator.pop(context);
        },
        haveleading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height / 10,
                width: width,
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text("Choice rooms",
                            style: TextStyle(fontSize: 25, color: Colors.white))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SingleRoom()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SizedBox(
                          height: height / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            color: const Color(0xFF2F2F42),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ListTile(
                                trailing: Icon(
                                  FontAwesomeIcons.doorOpen,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 3),
                                title: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 1),
                                  child: Text(
                                    // "${listKey[index].title}",
                                    "702",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      // listKey[index].status! ? "close" : "open",
                                      "PAT",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text("Free",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF05FF3C),
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
