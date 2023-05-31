import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Challenges/Homescreen/challenge_appbar.dart';

class ChallengeEditBody extends StatefulWidget {
  const ChallengeEditBody({Key? key}) : super(key: key);

  @override
  _ChallengeEditBodyState createState() => _ChallengeEditBodyState();
}

class _ChallengeEditBodyState extends State<ChallengeEditBody> {
  late List<DocumentSnapshot<Map<String, dynamic>>> sessions;

  @override
  void initState() {
    super.initState();
    sessions = [];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('WorkoutChallenges')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        sessions = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('NO')),
              DataColumn(label: Text('Challenge Title')),
              DataColumn(label: Text('Challenge Type')),
              DataColumn(label: Text('Start Date')),
              DataColumn(label: Text('End Date')),
              DataColumn(label: Text('Challenge Description')),
              DataColumn(label: Text('Edit')),
            ],
            rows: sessions.map((sessionData) {
              final data = sessionData.data()!;
              final index = sessions.indexOf(sessionData) + 1;

              return DataRow(
                cells: [
                  DataCell(
                    Container(
                      width: 80,
                      child: Text('$index'),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      child: Text(data['title'] ?? ''),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      child: Text(data['type'] ?? ''),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      child: Text(
                          (data['startDate'] as Timestamp).toDate().toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      child: Text(
                          (data['endDate'] as Timestamp).toDate().toString()),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: 80,
                      child: Text(data['description'] ?? ''),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _navigateToEditPage(context, sessionData);
                      },
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

  void _navigateToEditPage(BuildContext context,
      DocumentSnapshot<Map<String, dynamic>> sessionData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditChallengePage(sessionData: sessionData),
      ),
    );
  }
}

class EditChallengePage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> sessionData;

  const EditChallengePage({Key? key, required this.sessionData})
      : super(key: key);

  @override
  _EditChallengePageState createState() => _EditChallengePageState();
}

class _EditChallengePageState extends State<EditChallengePage> {
  late TextEditingController titleController;
  late String? selectedType;
  late DateTime? startDate;
  late DateTime? endDate;
  late TextEditingController descriptionController;

  final List<String> challengeTypes = [
    'Badminton',
    'Gym',
    'Futsal',
    'Jogging',
    'Volleyball',
    'Tennis',
    'Basketball',
    'Swimming',
    'Football'
    // Add more challenge types here as needed
  ];

  @override
  void initState() {
    super.initState();

    final data = widget.sessionData.data()!;
    titleController = TextEditingController(text: data['title'] ?? '');
    selectedType = data['type'];
    startDate = (data['startDate'] as Timestamp).toDate();
    endDate = (data['endDate'] as Timestamp).toDate();
    descriptionController =
        TextEditingController(text: data['description'] ?? '');
  }

  @override
  void dispose() {
    titleController.dispose();
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
            const ChallengeAppBar(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'EDIT WORKOUT CHALLENGE',
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
                          TextField(
                            controller: titleController,
                            decoration:
                                InputDecoration(labelText: 'Challenge Title'),
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedType,
                            onChanged: (newValue) {
                              setState(() {
                                selectedType = newValue;
                              });
                            },
                            items: challengeTypes.map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            decoration:
                                InputDecoration(labelText: 'Challenge Type'),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                              'Start Date: ${startDate != null ? startDate.toString() : 'Not selected'}'),
                          ElevatedButton(
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: startDate ?? DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  startDate = selectedDate;
                                });
                              }
                            },
                            child: Text('Select Start Date'),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                              'End Date: ${endDate != null ? endDate.toString() : 'Not selected'}'),
                          ElevatedButton(
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: endDate ?? DateTime.now(),
                                firstDate: startDate ?? DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  endDate = selectedDate;
                                });
                              }
                            },
                            child: Text('Select End Date'),
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                                labelText: 'Challenge Description'),
                          ),
                          ElevatedButton(
                            onPressed: _saveChanges,
                            child: Text('Save Changes'),
                          ),
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    final updatedData = {
      'title': titleController.text,
      'type': selectedType,
      'startDate': Timestamp.fromDate(startDate!),
      'endDate': Timestamp.fromDate(endDate!),
      'description': descriptionController.text,
    };

    widget.sessionData.reference.update(updatedData);

    Navigator.pop(context);
  }
}
