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

        final sessions = snapshot.data!.docs;

        return Container(
          height: 400, // Set a fixed height here
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Session ID')),
                DataColumn(label: Text('Session Title')),
                DataColumn(label: Text('Session Type')),
                DataColumn(label: Text('Session Date')),
                DataColumn(label: Text('Session Start Time')),
                DataColumn(label: Text('Session End Time')),
                DataColumn(label: Text('Session Max People')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Participants')),
              ],
              rows: sessions.map((session) {
                final sessionData = session.data() as Map<String, dynamic>;
                final participants =
                    sessionData['participants'] as List<dynamic>;
                final participantNames = participants.join(', ');

                return DataRow(
                  cells: [
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['SessionId'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['Title'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['Type'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['Date'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['Start Time'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['End Time'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['Max ppl'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(sessionData['Description'] ?? ''),
                    )),
                    DataCell(Container(
                      width: 80,
                      height: 400,
                      child: Text(participantNames),
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
