import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../View Session/sessionapp_bar.dart';

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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                final participants =
                    sessionData['participants'] as List<dynamic>?;
                final participantNames = participants?.join(', ') ?? '';

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
                      child: Text(
                          sessionData['Maximum Participants'].toString() ?? ''),
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
    final sessionQuery = FirebaseFirestore.instance
        .collection('WorkoutSession')
        .where('uniqueId', isEqualTo: editedSessionData['uniqueId']);

    final sessionQuerySnapshot = await sessionQuery.get();

    if (sessionQuerySnapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session does not exist')),
      );
      return;
    }

    final sessionDocRef = sessionQuerySnapshot.docs[0].reference;

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

//---------------------------------------------------------------------------//

class EditPage extends StatefulWidget {
  final Map<String, dynamic> sessionData;

  const EditPage({Key? key, required this.sessionData}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController titleController;
  late TextEditingController typeController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController maxPeopleController;
  late TextEditingController descriptionController;

  // List of Workout Types Listed here
  final List<String> sessionTypes = [
    'Badminton',
    'Gym',
    'Futsal',
    'Jogging',
    'Volleyball',
    'Tennis',
    'Basketball',
    'Swimming',
    'Football'
  ];

  // List of Max people
  final List<String> maxpeople = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.sessionData['Title']);
    typeController = TextEditingController(text: widget.sessionData['Type']);
    dateController = TextEditingController(text: widget.sessionData['Date']);
    startTimeController =
        TextEditingController(text: widget.sessionData['Start Time']);
    endTimeController =
        TextEditingController(text: widget.sessionData['End Time']);
    maxPeopleController = TextEditingController(
        text: widget.sessionData['Maximum Participants'].toString());
    descriptionController =
        TextEditingController(text: widget.sessionData['Description']);
  }

  @override
  void dispose() {
    titleController.dispose();
    typeController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    maxPeopleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SessionAppBar(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'EDIT WORKOUT SESSIONS',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                  width: size.width * 0.8, // Adjust the width as needed
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: titleController,
                            decoration:
                                InputDecoration(labelText: 'Session Title'),
                          ),
                          DropdownButtonFormField<String>(
                            value: typeController.text,
                            decoration:
                                InputDecoration(labelText: 'Session Type'),
                            onChanged: (String? newValue) {
                              setState(() {
                                typeController.text = newValue ?? '';
                              });
                            },
                            items: sessionTypes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            controller: dateController,
                            decoration: InputDecoration(
                              labelText: 'Date',
                            ),
                            onTap: () async {
                              final DateTime? selectedDate =
                                  await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              if (selectedDate != null) {
                                setState(() {
                                  dateController.text = selectedDate.toString();
                                });
                              }
                            },
                          ),
                          TextFormField(
                            controller: startTimeController,
                            decoration:
                                InputDecoration(labelText: 'Start Time'),
                          ),
                          TextFormField(
                            controller: endTimeController,
                            decoration: InputDecoration(labelText: 'End Time'),
                          ),
                          DropdownButtonFormField<String>(
                            value: maxPeopleController.text,
                            decoration:
                                InputDecoration(labelText: 'Max Session Time'),
                            onChanged: (String? newValue) {
                              setState(() {
                                maxPeopleController.text = newValue ?? '';
                              });
                            },
                            items: maxpeople
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            controller: descriptionController,
                            decoration:
                                InputDecoration(labelText: 'Description'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final editedData = {
                                'SessionId': widget.sessionData['SessionId'],
                                'Title': titleController.text,
                                'Type': typeController.text,
                                'Date': dateController.text,
                                'Start Time': startTimeController.text,
                                'End Time': endTimeController.text,
                                'Maximum Participants':
                                    int.parse(maxPeopleController.text),
                                'Description': descriptionController.text,
                              };

                              Navigator.pop(context, editedData);
                            },
                            child: Text('Save'),
                          ),
                        ],
                      ))),
            )
          ]),
    ));
  }
}
