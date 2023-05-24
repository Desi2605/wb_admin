import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditSessionBody extends StatefulWidget {
  const EditSessionBody({Key? key}) : super(key: key);

  @override
  _EditSessionBodyState createState() => _EditSessionBodyState();
}

class _EditSessionBodyState extends State<EditSessionBody> {
  late List<Map<String, dynamic>> sessionsData;
  late Map<String, dynamic> editedSessionData;

  @override
  void initState() {
    super.initState();
    sessionsData = [];
    editedSessionData = {};
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
          return CircularProgressIndicator();
        }

        final sessions = snapshot.data!.docs;
        sessionsData = sessions
            .map((session) => session.data() as Map<String, dynamic>)
            .toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 10,
            columns: [
              DataColumn(
                label: Container(
                  width: 80,
                  child: Text('Session ID'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 120,
                  child: Text('Session Title'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('Session Type'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: Text('Date'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('Start Time'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('End Time'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 100,
                  child: Text('Max People'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 120,
                  child: Text('Description'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 120,
                  child: Text('Participants'),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: Text('Edit'),
                ),
              ),
            ],
            rows: sessionsData.map((sessionData) {
              final participants = sessionData['participants'] as List<dynamic>;
              final participantNames = participants.join(', ');

              return DataRow(
                cells: [
                  DataCell(Container(
                    width: 80,
                    child: Text(sessionData['SessionId'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 120,
                    child: Text(sessionData['Title'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['Type'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 80,
                    child: Text(sessionData['Date'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['Start Time'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['End Time'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 100,
                    child: Text(sessionData['Max ppl'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 120,
                    child: Text(sessionData['Description'] ?? ''),
                  )),
                  DataCell(Container(
                    width: 120,
                    child: Text(participantNames),
                  )),
                  DataCell(IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        editedSessionData = sessionData;
                      });
                      _navigateToEditPage(context);
                    },
                  )),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _navigateToEditPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(
          sessionData: editedSessionData,
        ),
      ),
    ).then((editedData) {
      if (editedData != null) {
        setState(() {
          editedSessionData = editedData;
        });
        _updateSessionData();
      }
    });
  }

  void _updateSessionData() async {
    final sessionDocRef = FirebaseFirestore.instance
        .collection('WorkoutSession')
        .doc(editedSessionData['sessionId']);

    final sessionDocSnapshot = await sessionDocRef.get();
    if (!sessionDocSnapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session does not exist')),
      );
      return;
    }

    try {
      await sessionDocRef.update(editedSessionData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update session: $error')),
      );
    }
  }
}

class EditPage extends StatefulWidget {
  final Map<String, dynamic> sessionData;

  const EditPage({Key? key, required this.sessionData}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController titleController;
  late TextEditingController typeController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.sessionData['Title']);
    typeController = TextEditingController(text: widget.sessionData['Type']);
  }

  @override
  void dispose() {
    titleController.dispose();
    typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Session'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Session Title'),
            ),
            TextFormField(
              controller: typeController,
              decoration: InputDecoration(labelText: 'Session Type'),
            ),
            // Add more fields for other session details that you want to edit
            ElevatedButton(
              onPressed: () {
                final editedData = {
                  'SessionId': widget.sessionData['SessionId'],
                  'Title': titleController.text,
                  'Type': typeController.text,
                  // Add more fields for other session details that you want to update
                };

                Navigator.pop(context, editedData);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
