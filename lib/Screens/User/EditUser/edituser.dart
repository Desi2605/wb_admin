import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class EditForm extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditForm({Key? key, required this.userData}) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial values in the text fields
    _firstnameController.text = widget.userData['Firstname'];
    _lastnameController.text = widget.userData['Lastname'];
    _usernameController.text = widget.userData['Username'];
    _emailController.text = widget.userData['Email'];
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  void updateUserDetails() {
    // Update the user details in the database using the provided data
    final updatedUserData = {
      'Firstname': _firstnameController.text,
      'Lastname': _lastnameController.text,
      'Username': _usernameController.text,
      'Email': _emailController.text,

      // Add more fields as needed
    };

    // Update the Firestore document with the new data
    FirebaseFirestore.instance
        .collection('Users')
        .doc(widget
            .userData['id']) // Use the 'id' field to identify the document
        .update(updatedUserData)
        .then((_) {
      // Show a success message or perform any other actions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User details updated successfully.'),
        ),
      );
    }).catchError((error) {
      // Show an error message or perform any other error handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update user details.'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstnameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: updateUserDetails,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
