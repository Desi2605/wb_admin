import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Challenges/Homescreen/challenge_appbar.dart';
import 'package:wb_admin/Screens/Challenges/Homescreen/challenge_body.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width  of our screen
    return Scaffold(
      body: SizedBox(
        height: size.height,
        // it will take full width
        width: size.width,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ChallengeAppBar(),
            Spacer(),
            // It will cover 1/3 of free spaces
            ChallengeBody(),
            Spacer(
              flex: 2,
            ),
            // it will cover 2/3 of free spaces
          ],
        ),
      ),
    );
  }
}
