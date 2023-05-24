import 'package:flutter/material.dart';
import 'package:wb_admin/constant.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome Admin".toUpperCase(),
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: kTextcolor,
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
