import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Home/home_screen.dart';
import 'package:wb_admin/Screens/Home/menu_item.dart';
import 'package:wb_admin/Screens/Session/Edit%20Session/edit_screen.dart';
import 'package:wb_admin/Screens/Session/Session%20Status/view_status.dart';
import 'package:wb_admin/Screens/Session/View%20Session/session_screen.dart';
import 'package:wb_admin/Screens/report/Report%20Status/view.dart';
import 'package:wb_admin/Screens/report/View%20Report/report_body.dart';
import 'package:wb_admin/Screens/report/View%20Report/report_screen.dart';

class ReportAppBar extends StatelessWidget {
  const ReportAppBar({super.key});

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
            title: "View Report",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportViewList()),
              );
            },
          ),
          MenuItem(
            title: "Report Status",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReportStatusScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
