import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Viewlist extends StatelessWidget {
  const Viewlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
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
            columns: <DataColumn>[
              DataColumn(
                label: Center(
                  child: Text(
                    'No',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                numeric: false,
              ),
              DataColumn(
                label: Center(child: Text('Firstname')),
              ),
              DataColumn(
                label: Center(child: Text('Lastname')),
              ),
              DataColumn(
                label: Center(child: Text('Username')),
              ),
              DataColumn(
                label: Center(child: Text('Email')),
              ),
              DataColumn(
                label: Center(child: Text('Account Status')),
              ),
            ],
            rows: users.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final user = entry.value;
              final userData = user.data() as Map<String, dynamic>;

              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Center(
                      child: Text('$index'),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(userData['Firstname']),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(userData['Lastname']),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(userData['Username']),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(userData['Email']),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Text(userData['AccountStatus']),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
