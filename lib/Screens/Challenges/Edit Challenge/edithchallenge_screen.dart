import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Challenges/Edit%20Challenge/editchallenge_body.dart';

import 'package:wb_admin/Screens/Session/Edit%20Session/edit_body.dart';

import '../Homescreen/challenge_appbar.dart';

class ChallengeEdit extends StatelessWidget {
  const ChallengeEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const ChallengeAppBar(),
            const Spacer(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'WORKOUT CHALLENGES ',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              child: Center(
                child: ChallengeEditBody(),
              ),
            ),

            Spacer(
              flex: 20,
            ),
            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );
  }
}
