import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportStatuslist extends StatefulWidget {
  const ReportStatuslist({Key? key});

  @override
  _ReportStatuslistState createState() => _ReportStatuslistState();
}

class _ReportStatuslistState extends State<ReportStatuslist> {
  List<String> sessionStatusOptions = [
    'Action Taken',
    'Investigating',
    'Pending',
  ];

  Map<String, String> sessionStatusMap = {
    'Action Taken': 'Action Taken',
    'Investigating': 'Investigating',
    'Pending': 'Pending',
  };

  Map<String, String> sessionStatus = {};

  Future<void> updateReportStatus(String sessionId, String status) async {
    try {
      // Update the session status in the database
      await FirebaseFirestore.instance
          .collection('Reports')
          .doc(sessionId)
          .update({'Report Status': status});
    } catch (error) {
      print('Error updating session status: $error');
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Reports').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          final sessions = snapshot.data!.docs;
          return DataTable(
            columns: const [
              DataColumn(label: Text('Report ID')),
              DataColumn(label: Text('Report Title')),
              DataColumn(label: Text('Report Date')),
              DataColumn(label: Text('Report Description')),
              DataColumn(label: Text('Report Status')),
              DataColumn(label: Text('Change Status')),
            ],
            rows: sessions.map((sessionData) {
              final data = sessionData.data() as Map<String, dynamic>;
              final sessionId = sessionData.id;

              return DataRow(
                cells: [
                  DataCell(
                    Text(data['Report ID'] ?? ''),
                  ),
                  DataCell(
                    Text(data['Title'] ?? ''),
                  ),
                  DataCell(
                    Text(
                      (data['Report Date'] as Timestamp?)
                              ?.toDate()
                              .toString() ??
                          '',
                    ),
                  ),
                  DataCell(
                    Text(data['Description'] ?? ''),
                  ),
                  DataCell(
                    Text(data['Report Status'] ?? ''),
                  ),
                  DataCell(
                    DropdownButton<String>(
                      value: data['Report Status'],
                      onChanged: (newValue) {
                        setState(() {
                          sessionStatus[sessionId] = newValue!;
                        });
                        updateReportStatus(sessionId, newValue!);
                      },
                      items: sessionStatusOptions
                          .map((status) => DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
