import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionStatuslist extends StatefulWidget {
  const SessionStatuslist({Key? key});

  @override
  _SessionStatuslistState createState() => _SessionStatuslistState();
}

class _SessionStatuslistState extends State<SessionStatuslist> {
  List<String> sessionStatusOptions = ['Active', 'Disabled', 'Ongoing'];

  Map<String, String> sessionStatusMap = {
    'Active': 'Active',
    'Disabled': 'Disabled',
    'Ongoing': 'Ongoing',
  };

  Map<String, String> sessionStatus = {};

  Future<void> updateSessionStatus(String sessionId, String status) async {
    try {
      // Update the session status in the database
      await FirebaseFirestore.instance
          .collection('WorkoutSession')
          .doc(sessionId)
          .update({'SessionStatus': status});
    } catch (error) {
      print('Error updating session status: $error');
    }
  }

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

        return SizedBox(
          height: 400, // Set a fixed height here
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Session ID')),
                DataColumn(label: Text('Session Title')),
                DataColumn(label: Text('Session Type')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Start Time')),
                DataColumn(label: Text('End Time')),
                DataColumn(label: Text('Max People')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Participants')),
                DataColumn(label: Text('Status')),
              ],
              rows: sessions.map((session) {
                final sessionData = session.data() as Map<String, dynamic>;
                final sessionId = session.id;
                final status = sessionStatus[sessionId] ?? 'Active';

                return DataRow(
                  cells: [
                    DataCell(Text(sessionData['SessionId'].toString() ??
                        '')), // Convert int to String
                    DataCell(Text(sessionData['Title'] ?? '')),
                    DataCell(Text(sessionData['Type'] ?? '')),
                    DataCell(Text(sessionData['Date'] ?? '')),
                    DataCell(Text(sessionData['Start Time'] ?? '')),
                    DataCell(Text(sessionData['End Time'] ?? '')),
                    DataCell(Text(
                        sessionData['Maximum Participants'].toString() ??
                            '')), // Convert int to String
                    DataCell(Text(sessionData['Description'] ?? '')),
                    DataCell(Text(
                        (sessionData['participants'] as List<dynamic>?)
                                ?.join(', ') ??
                            '')),

                    DataCell(
                      DropdownButton<String>(
                        value: status,
                        items: sessionStatusOptions.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            sessionStatus[sessionId] = newValue!;
                            updateSessionStatus(sessionId, newValue!);
                          });
                        },
                      ),
                    ),
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
