import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSessionPage extends StatefulWidget {
  final String sessionId;

  const EditSessionPage({Key? key, required this.sessionId}) : super(key: key);

  @override
  _EditSessionPageState createState() => _EditSessionPageState();
}

class _EditSessionPageState extends State<EditSessionPage> {
  String sessionTitle = '';
  String sessionType = '';
  // Add more fields as needed

  @override
  void initState() {
    super.initState();
    // Fetch session details from Firestore based on the session ID
    fetchSessionDetails();
  }

  void fetchSessionDetails() async {
    try {
      final sessionDoc = await FirebaseFirestore.instance
          .collection('WorkoutSession')
          .doc(widget.sessionId)
          .get();

      if (sessionDoc.exists) {
        final sessionData = sessionDoc.data() as Map<String, dynamic>;
        setState(() {
          sessionTitle = sessionData['Title'] ?? '';
          sessionType = sessionData['Type'] ?? '';
          // Assign more fields as needed
        });
      }
    } catch (error) {
      // Handle error
    }
  }

  void saveChanges() async {
    try {
      final sessionRef = FirebaseFirestore.instance
          .collection('WorkoutSession')
          .doc(widget.sessionId);

      await sessionRef.update({
        'Title': sessionTitle,
        'Type': sessionType,
        // Update more fields as needed
      });

      // Navigate back to the previous screen
      Navigator.pop(context);
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: sessionTitle,
              onChanged: (value) {
                setState(() {
                  sessionTitle = value;
                });
              },
              decoration: InputDecoration(labelText: 'Session Title'),
            ),
            TextFormField(
              initialValue: sessionType,
              onChanged: (value) {
                setState(() {
                  sessionType = value;
                });
              },
              decoration: InputDecoration(labelText: 'Session Type'),
            ),
            // Add more form fields for other session details

            ElevatedButton(
              onPressed: saveChanges,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
