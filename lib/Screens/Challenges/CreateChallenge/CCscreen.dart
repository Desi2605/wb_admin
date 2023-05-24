import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Challenges/CreateChallenge/create_challenge.dart';

import '../Homescreen/challenge_appbar.dart';

class CCScreen extends StatelessWidget {
  const CCScreen({Key? key});

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
            const ChallengeAppBar(),
            const Spacer(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'CREATE WORKOUT CHALLENGES',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            CreateWorkoutChallenge(),

            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );
  }
}
