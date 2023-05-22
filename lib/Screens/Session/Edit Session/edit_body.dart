import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'EditSessionPage.dart';

class EditSessionBody extends StatelessWidget {
  const EditSessionBody({Key? key}) : super(key: key);

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

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 10,
            columns: [
              DataColumn(
                label: Container(
                  width: 80,
                  child: Text('Session ID'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 120,
                  child: Text('Session Title'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('Session Type'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: Text('Date'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('Start Time'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('End Time'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('Max People'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 120,
                  child: Text('Description'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 120,
                  child: Text('Participants'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: Text('Edit'),
                ),
              ),
            ],
            rows: sessions.map((session) {
              final sessionData = session.data() as Map<String, dynamic>;
              final participants = sessionData['participants'] as List<dynamic>;
              final participantNames = participants.join(', ');

              return DataRow(
                cells: [
                  DataCell(Container(
                    width: 80,
                    child: Text(sessionData['SessionId'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 120,
                    child: Text(sessionData['Title'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['Type'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80,
                    child: Text(sessionData['Date'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['Start Time'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['End Time'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['Max ppl'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 120,
                    child: Text(sessionData['Description'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 120,
                    child: Text(participantNames),
                  )),
                  DataCell(IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditSessionPage(sessionId: session.id),
                        ),
                      );
                    },
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
