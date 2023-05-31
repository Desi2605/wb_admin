import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Home/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomAppBar(),
            SizedBox(height: 120),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 16, 40, 8),
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Welcome Admin",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: DocumentCountCard(),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SessionCountCard(),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ChallengeCountCard(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentCountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.person, size: 40, color: Colors.blue),
            SizedBox(width: 16),
            Expanded(
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final count = snapshot.data!.size;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Users Registered',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            count.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionCountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.calendar_today, size: 40, color: Colors.orange),
            SizedBox(width: 16),
            Expanded(
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('WorkoutSession')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final count = snapshot.data!.size;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Workout Sessions',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            count.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeCountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.fitness_center, size: 40, color: Colors.green),
            SizedBox(width: 16),
            Expanded(
              child: Center(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('WorkoutChallenges')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final count = snapshot.data!.size;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Workout Challenges',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            count.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
