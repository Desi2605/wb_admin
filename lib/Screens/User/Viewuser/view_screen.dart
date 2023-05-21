import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/User/MainScreen/user_app_bar.dart';
import 'package:wb_admin/Screens/User/Viewuser/userviewlist.dart';

class Userviewlist extends StatelessWidget {
  const Userviewlist({Key? key});

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
            UserAppBar(),
            Spacer(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'USER DETAILS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Viewlist(),
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
