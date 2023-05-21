import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/User/MainScreen/user_app_bar.dart';
import 'package:wb_admin/Screens/User/UserStatus/userstatus.dart';

class Statusviewlist extends StatelessWidget {
  const Statusviewlist({Key? key});

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
            const UserAppBar(),
            const Spacer(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'UPDATE USER STATUS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              height: size.height * 0.7, // Adjust the height as needed
              child: SingleChildScrollView(
                child: Center(
                  child: Statuslist(),
                ),
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
