import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Challenges/ViewChallenge/view_body.dart';
import 'package:wb_admin/Screens/User/MainScreen/user_app_bar.dart';
import 'package:wb_admin/Screens/User/Viewuser/userviewlist.dart';

import '../Homescreen/challenge_appbar.dart';

class ChallengeViewScreen extends StatelessWidget {
  const ChallengeViewScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides us the total height and width of our screen
    return Scaffold(
      body: SizedBox(
        height: size.height,
        // it will take full width
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ChallengeAppBar(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'WORKOUT CHALLENGES',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Center(
              child:
                  ChallengeViewBody(), // Use a different widget for the view list
            ),
          ],
        ),
      ),
    );
  }
}
