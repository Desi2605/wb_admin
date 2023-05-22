import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Session/View%20Session/sessionapp_bar.dart';
import 'package:wb_admin/Screens/Session/View%20Session/session_body.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

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
            SessionAppBar(),
            Spacer(),
            // It will cover 1/3 of free spaces
            SessionBody(),
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
