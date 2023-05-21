import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Home/home_screen.dart';
import 'package:wb_admin/Screens/Home/menu_item.dart';
import 'package:wb_admin/Screens/User/UserStatus/view_status.dart';
import 'package:wb_admin/Screens/User/Viewuser/view_screen.dart';

class UserAppBar extends StatelessWidget {
  const UserAppBar({super.key});

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
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
          ),
          MenuItem(
            title: "View Users",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Userviewlist()),
              );
            },
          ),
          MenuItem(
            title: "User Status",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Statusviewlist()),
              );
            },
          ),
          MenuItem(
            title: "Edit User Details",
            press: () {},
          ),
        ],
      ),
    );
  }
}
