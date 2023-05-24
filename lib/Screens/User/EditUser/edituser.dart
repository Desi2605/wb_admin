import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../MainScreen/user_app_bar.dart';
import 'editform.dart';

class Editlist extends StatelessWidget {
  const Editlist({Key? key}) : super(key: key);

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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
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
                ],
                rows: users.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final user = entry.value;
                  final userData = user.data() as Map<String, dynamic>;

                  // Include the 'id' field in the user data
                  final userDataWithId = {...userData, 'id': user.id};

                  return DataRow(
                    onSelectChanged: (selected) {
                      if (selected != null && selected) {
                        // Navigate to the edit form page and pass the user's data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditForm(userData: userDataWithId),
                          ),
                        );
                      }
                    },
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
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
//--------------------------------------------------------------------------------------//


