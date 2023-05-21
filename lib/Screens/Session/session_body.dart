import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionBody extends StatelessWidget {
  const SessionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('WorkoutSession').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final users = snapshot.data!.docs;

        return SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Session ID')),
              DataColumn(label: Text('Session Title')),
              DataColumn(label: Text('Session Type')),
              DataColumn(label: Text('Session Date')),
              DataColumn(label: Text('Session Start Time')),
              DataColumn(label: Text('Session End Time')),
              DataColumn(label: Text('Session Max People')),
              DataColumn(label: Text('Description')),
              DataColumn(label: Text('Participants'))
            ],
            rows: users.map((user) {
              final userData = user.data() as Map<String, dynamic>;
              return DataRow(
                cells: [
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['SessionId'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['Title'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['Type'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['Date'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['Start Time'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['End Time'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['Max ppl'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['Description'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80, // Adjust the width as needed
                    child: Text(userData['displayName'] ?? ''),
                  )),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
