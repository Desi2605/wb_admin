import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Retrieve user data from Firebase Firestore
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Login successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Login unsuccessful
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Invalid email or password.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error logging in: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while logging in.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 3, 3, 3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.easeInOut,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    Image.asset(
                      'assets/images/volleyadmin.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/footballadmin.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/gymadmin.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/swimadmin.jpeg',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/BadmintonAdmin.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 102, 102, 94),
                      Color.fromARGB(255, 0, 0, 0),
                      Color.fromARGB(255, 102, 102, 94),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 300.0,
                      width: 300.0,
                      child: Image.asset(
                        'assets/images/adminlogo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.grey[300],
                      ),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.grey[300],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _loginUser,
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
