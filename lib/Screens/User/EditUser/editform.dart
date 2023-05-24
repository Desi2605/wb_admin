import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/User/MainScreen/user_app_bar.dart';

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
    Size size = MediaQuery.of(context).size;
    // This size provides us the total height and width of our screen
    return Scaffold(
      body: SizedBox(
        height: size.height,
        // it will take full width
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAppBar(),
            Spacer(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'EDIT USER DETAILS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Spacer(),
            TextFormField(
              controller: _firstnameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastnameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: updateUserDetails,
              child: Text('Update'),
            ),
            Spacer(
              flex: 15,
            ),
          ],
        ),
      ),
    );
  }
}
