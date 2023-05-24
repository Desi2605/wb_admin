import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeViewBody extends StatelessWidget {
  const ChallengeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('WorkoutChallenges')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final sessions = snapshot.data!.docs;

        return Container(
          height: 400, // Set a fixed height here
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('NO')),
                DataColumn(label: Text('Challenge Title')),
                DataColumn(label: Text('Challenge Type')),
                DataColumn(label: Text('Start Date')),
                DataColumn(label: Text('End Date')),
                DataColumn(label: Text('Challenge Description')),
              ],
              rows: sessions.map((sessionData) {
                final data = sessionData.data() as Map<String, dynamic>;
                final index = sessions.indexOf(sessionData) + 1;

                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text('$index'),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['title'] ?? ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['type'] ?? ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text((data['startDate'] as Timestamp)
                                .toDate()
                                .toString() ??
                            ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text((data['endDate'] as Timestamp)
                                .toDate()
                                .toString() ??
                            ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['description'] ?? ''),
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
