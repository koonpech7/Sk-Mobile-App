import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SKAppBar extends AppBar {
  SKAppBar({
    super.key,
    required String title,
    String subtitle = "",
    bool haveleading = true,
    bool havetactions = true,
    required VoidCallback onPressed,
  }) : super(
          toolbarHeight: 120,
          backgroundColor: const Color(0xFF1F1F39),
          leading: haveleading
              ? IconButton(
                  onPressed: onPressed,
                  icon: const Icon(FontAwesomeIcons.chevronLeft),
                  iconSize: 30,
                )
              : SizedBox(),
          titleSpacing: 0,
          title: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 1),
              Text(
                subtitle,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          elevation: 0,
          actions: <Widget>[
            havetactions
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  )
                : SizedBox()
          ],
        );
}
