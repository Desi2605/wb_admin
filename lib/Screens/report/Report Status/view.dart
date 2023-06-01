import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Session/Edit%20Session/edit_body.dart';
import 'package:wb_admin/Screens/Session/Session%20Status/sessionstatus.dart';
import 'package:wb_admin/Screens/User/UserStatus/userstatus.dart';
import 'package:wb_admin/Screens/report/Report%20Status/reportstatus.dart';

import '../View Report/report_appbar.dart';

class ReportStatusScreen extends StatelessWidget {
  const ReportStatusScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides us the total height and width of our screen
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const ReportAppBar(),
          const Spacer(),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'REPORT STATUS',
                style: GoogleFonts.bebasNeue(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            // Adjust the height as needed
            child: SingleChildScrollView(
              child: Center(
                child: ReportStatuslist(),
              ),
            ),
          ),
          Spacer(
            flex: 20,
          ),
          // it will cover 2/3 of free spaces
        ],
      ),
    );
  }
}
