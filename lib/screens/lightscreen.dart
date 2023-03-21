import 'package:flutter/material.dart';
import 'package:testflutter/components/appbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quickalert/quickalert.dart';

class LightScreens extends StatefulWidget {
  const LightScreens({super.key});

  @override
  State<LightScreens> createState() => _LightScreensState();
}

class _LightScreensState extends State<LightScreens> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.green;
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Room 702",
        subtitle: "Choice your feature",
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              // color: Colors.black,
              height: height / 1.3,
              width: width,
              child: Column(
                children: [
                  SizedBox(height: height / 12),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text(
                          "Check All",
                          style: TextStyle(fontSize: 45, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: width / 8),
                      Transform.scale(
                        scale: 2,
                        child: Checkbox(
                          value: isChecked,
                          activeColor: Colors.green,
                          hoverColor: Colors.blue,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          onChanged: (newBool) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'Do you want to open all leamp',
                              confirmBtnText: 'Yes',
                              cancelBtnText: 'No',
                              confirmBtnColor: Colors.green,
                              onConfirmBtnTap: () {
                                setState(() {
                                  isChecked = newBool;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 8,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.lightbulb),
                        color: Colors.red,
                        iconSize: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 1 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: Colors.green,
                        iconSize: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 2 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.lightbulb),
                        color: Colors.red,
                        iconSize: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 3 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: Colors.green,
                        iconSize: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 4 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: height / 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.lightbulb),
                        color: Colors.red,
                        iconSize: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 5 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.solidLightbulb),
                        color: Colors.green,
                        iconSize: 50,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Light 6 ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
