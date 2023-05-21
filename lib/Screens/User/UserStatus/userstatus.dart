import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Statuslist extends StatefulWidget {
  const Statuslist({Key? key});

  @override
  _StatuslistState createState() => _StatuslistState();
}

class _StatuslistState extends State<Statuslist> {
  List<String> accountStatusOptions = ['Active', 'Disabled'];

  Map<String, String> accountStatusMap = {
    'Active': 'Active',
    'Disabled': 'Disabled',
  };

  Map<String, String> userAccountStatus = {};

  Future<void> updateAccountStatus(String userId, String accountStatus) async {
    try {
      // Update the account status in the database
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .update({'AccountStatus': accountStatus});
    } catch (error) {
      print('Error updating account status: $error');
    }
  }

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
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: DataTable(
              dataRowHeight: 50,
              columns: const [
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('Firstname'),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('Lastname'),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('Username'),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    width: 100,
                    child: Text('Email'),
                  ),
                ),
                DataColumn(
                  label: Text('Account Status'),
                ),
              ],
              rows: users.map((user) {
                final userData = user.data() as Map<String, dynamic>;
                final userId = user.id;
                final accountStatus = userAccountStatus[userId] ?? 'Active';

                return DataRow(
                  cells: [
                    DataCell(Text(userData['Firstname'])),
                    DataCell(Text(userData['Lastname'])),
                    DataCell(Text(userData['Username'])),
                    DataCell(Text(userData['Email'])),
                    DataCell(
                      DropdownButton<String>(
                        value: accountStatus,
                        items: accountStatusOptions.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(accountStatusMap[status]!),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            userAccountStatus[userId] = newValue!;
                            updateAccountStatus(userId, newValue!);
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
