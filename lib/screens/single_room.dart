import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/components.dart';
import '../models/models.dart';

class SingleRoom extends StatefulWidget {
  const SingleRoom({
    super.key,
  });

  @override
  State<SingleRoom> createState() => _SingleRoomState();
}

class _SingleRoomState extends State<SingleRoom> {
  late bool room1;
  late bool room2;
  late bool room3;
  late bool room4;

  @override
  void initState() {
    room1 = false;
    room2 = false;
    room3 = false;
    room4 = false;

    super.initState();
  }

  void _onPressed(index) {
    switch (index) {
      case 1:
        setState(() {
          room1 = !room1;
        });
        break;
      case 2:
        setState(() {
          room2 = !room2;
        });
        break;

      case 3:
        setState(() {
          room3 = !room3;
        });
        break;

      case 4:
        setState(() {
          room4 = !room4;
        });
        break;

      default:
    }

    // print("initStatus status : " + "${room1}");
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    List<ListKey> listKey = [
      ListKey(id: 1, title: "Door", status: room1),
      ListKey(id: 2, title: "Lamp", status: room2),
      ListKey(id: 3, title: "Air", status: room3),
      ListKey(id: 4, title: "Camera", status: room4)
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Room 704",
        subtitle: "Choice your feature",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: height / 8,
              width: width,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFF8EE592),
                        radius: 30,
                        child: Text(
                          '1',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Color(0xFF797979),
                        radius: 30,
                        child: Text(
                          '2',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 20),
                      CircleAvatar(
                        backgroundColor: Color(0xFF797979),
                        radius: 30,
                        child: Text(
                          '3',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: height / 1.7,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listKey.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onPressed(index + 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        height: height / 7,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                          color: const Color(0xFF2F2F42),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              title: Text(
                                "${listKey[index].title}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                listKey[index].status! ? "close" : "open",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: listKey[index].status!
                                      ? Color(0xFFFF0505)
                                      : Color(0xFF05FF3C),
                                ),
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: Color(0xFF69696F),
                                radius: 30,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: listKey[index].status!
                                      ? Icon(FontAwesomeIcons.lock)
                                      : Icon(FontAwesomeIcons.unlock),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
