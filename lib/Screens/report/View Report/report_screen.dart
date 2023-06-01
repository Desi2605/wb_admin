import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:wb_admin/Screens/Session/Edit%20Session/edit_body.dart';
import 'package:wb_admin/Screens/Session/Session%20Status/sessionstatus.dart';
import 'package:wb_admin/Screens/Session/View%20Session/session_body.dart';
import 'package:wb_admin/Screens/User/UserStatus/userstatus.dart';
import 'package:wb_admin/Screens/report/View%20Report/report_appbar.dart';
import 'package:wb_admin/Screens/report/View%20Report/report_body.dart';

class ReportViewList extends StatelessWidget {
  const ReportViewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          const ReportAppBar(),
          const Spacer(),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'REPORTS',
                style: GoogleFonts.bebasNeue(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            child: SingleChildScrollView(
              child: Center(
                child: ReportViewBody(),
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
