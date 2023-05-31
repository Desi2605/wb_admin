import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Challenges/Homescreen/challenge_screen.dart';
import 'package:wb_admin/Screens/Home/login.dart';
import 'package:wb_admin/Screens/User/MainScreen/user_screen.dart';
import 'package:wb_admin/Screens/Session/View%20Session/session_screen.dart';
import 'menu_item.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

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
          Image.asset(
            "assets/images/Logo2.png",
            height: 50,
            width: 80,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(width: 10),
          Text(
            "UNITEN WORKOUT BUDDIES ADMIN".toUpperCase(),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          MenuItem(
            title: "Homepage",
            press: () {},
          ),
          MenuItem(
            title: "Users",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserScreen()),
              );
            },
          ),
          MenuItem(
            title: "WorkOut Sessions",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SessionViewList()),
              );
            },
          ),
          MenuItem(
            title: "Workout Challenges",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChallengeScreen()),
              );
            },
          ),
          MenuItem(
            title: "Log Out",
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
