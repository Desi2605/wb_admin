import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportViewBody extends StatelessWidget {
  const ReportViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Reports').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final sessions = snapshot.data!.docs;

        return Container(
          child: SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Report ID')),
                DataColumn(label: Text('Report Title')),
                DataColumn(label: Text('Report Date')),
                DataColumn(label: Text('Report Description')),
                DataColumn(label: Text('Report Status')),
              ],
              rows: sessions.map((sessionData) {
                final data = sessionData.data() as Map<String, dynamic>;

                return DataRow(
                  cells: [
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['Report ID'] ?? ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['Title'] ?? ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text((data['Report Date'] as Timestamp?)
                                ?.toDate()
                                .toString() ??
                            ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['Description'] ?? ''),
                      ),
                    ),
                    DataCell(
                      Container(
                        width: 80,
                        height: 400,
                        child: Text(data['Report Status'] ?? ''),
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
