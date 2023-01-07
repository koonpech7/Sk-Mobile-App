import 'package:flutter/material.dart';
import 'package:testflutter/components/components.dart';
import 'package:testflutter/screens/screens.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: SKAppBar(
        title: "Hi Admin",
        subtitle: "good morning",
        onPressed: () {
          Navigator.pop(context);
        },
        haveleading: false,
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Column(
              children: [
                Container(
                  child: ElevatedButton(
                    child: Text("to single page"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IndexRoom()),
                      );
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text("Notification Pages"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
