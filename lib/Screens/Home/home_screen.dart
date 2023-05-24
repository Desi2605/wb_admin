import 'package:flutter/material.dart';
import 'package:wb_admin/Screens/Home/app_bar.dart';
import 'package:wb_admin/Screens/Home/body.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize Firebase Analytics

    // Fetch user login data from Firebase Analytics
    Future<List<charts.Series<LoginData, String>>> fetchLoginData() async {
      // Retrieve user login data from Firebase Analytics
      // ...

      // Transform the data into the desired format for the chart
      List<LoginData> chartData = [
        LoginData(label: 'Monday', value: 10),
        LoginData(label: 'Tuesday', value: 20),
        LoginData(label: 'Wednesday', value: 15),
        LoginData(label: 'Thursday', value: 8),
        LoginData(label: 'Friday', value: 12),
      ];

      // Return a list of chart series
      return [
        charts.Series<LoginData, String>(
          id: 'loginData',
          data: chartData,
          domainFn: (LoginData data, _) => data.label,
          measureFn: (LoginData data, _) => data.value,
          labelAccessorFn: (LoginData data, _) =>
              '${data.label}: ${data.value}',
        ),
      ];
    }

    // Build the chart widget
    Widget buildLoginChart() {
      return FutureBuilder<List<charts.Series<LoginData, String>>>(
        future: fetchLoginData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return charts.BarChart(
              snapshot.data!,
              animate: true,
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bg1.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomAppBar(),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Body(), // Replace with your desired widget
                    ),
                  ),
                ],
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

// Example class for login data
class LoginData {
  final String label;
  final int value;

  LoginData({required this.label, required this.value});
}
