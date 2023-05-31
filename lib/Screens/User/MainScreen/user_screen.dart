import 'dart:html';

import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/User/MainScreen/user_app_bar.dart';
import 'package:wb_admin/Screens/User/MainScreen/userBody.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAppBar(),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[],
              ),
            ),
            //Expanded(
            //flex: 1,
            //child: Row(
            // children: <Widget>[
            //Expanded(
            //child: Container(
            //  child: buildLoginChart(), // Display the login chart here
            //),
            //),
            // ],
            //),
            //),
          ],
        ),
      ),
    );
  }
}
