import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: const Color(0xFF1F1F39),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          iconSize: 30,
        ),
        titleSpacing: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Room 702',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1),
            Text(
              'Choice your course',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.userTie),
                iconSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: height / 6,
                width: width,
                color: Colors.red,
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [Text("data1")],
                ),
              ),
              Container(
                color: Colors.green,
                height: height,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/147/147142.png'),
                        radius: 30,
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
