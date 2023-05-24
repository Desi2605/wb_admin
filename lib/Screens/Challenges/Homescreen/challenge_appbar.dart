import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Challenges/CreateChallenge/CCscreen.dart';
import 'package:wb_admin/Screens/Challenges/CreateChallenge/create_challenge.dart';

import 'package:wb_admin/Screens/Challenges/ViewChallenge/view_screen.dart';
import 'package:wb_admin/Screens/Home/home_screen.dart';
import 'package:wb_admin/Screens/Home/menu_item.dart';

class ChallengeAppBar extends StatelessWidget {
  const ChallengeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(46),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.16),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 10),
          Text(
            "UNITEN WORKOUT BUDDIES ADMIN".toUpperCase(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MenuItem(
            title: "Homepage",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          MenuItem(
            title: "Create Challenge",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CCScreen()),
              );
            },
          ),
          MenuItem(
            title: "View Challenges",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChallengeViewScreen()),
              );
            },
          ),
          MenuItem(
            title: "Edit Challenges Details",
            press: () {},
          ),
        ],
      ),
    );
  }
}
