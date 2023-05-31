import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wb_admin/Screens/Challenges/Homescreen/challenge_appbar.dart';

class CreateWorkoutChallenge extends StatefulWidget {
  const CreateWorkoutChallenge({Key? key}) : super(key: key);

  @override
  _CreateWorkoutChallengeState createState() => _CreateWorkoutChallengeState();
}

class _CreateWorkoutChallengeState extends State<CreateWorkoutChallenge> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _uploadData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Get the entered values
      String title = _titleController.text;
      String type = _typeController.text;
      DateTime? startDate = _startDate;
      DateTime? endDate = _endDate;
      String description = _descriptionController.text;

      // Create a new document in Firestore
      try {
        await FirebaseFirestore.instance.collection('WorkoutChallenges').add({
          'ChallengeId': UniqueKey().toString(),
          'title': title,
          'type': type,
          'startDate': startDate,
          'endDate': endDate,
          'description': description,
        });
        // Show success message or navigate to a different screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Workout challenge created successfully!'),
          ),
        );
      } catch (error) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create workout challenge. $error'),
          ),
        );
      }
    }
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
                  'CREATE WORKOUT CHALLENGE',
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'TITLE OF CHALLENGE';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _typeController,
                        decoration:
                            const InputDecoration(labelText: 'Type of Workout'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'WORKOUT TYPE';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Text('Start Date: ${_startDate ?? 'Not selected'}'),
                      ElevatedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _startDate = selectedDate;
                            });
                          }
                        },
                        child: const Text('START DATE'),
                      ),
                      const SizedBox(height: 16.0),
                      Text('End Date: ${_endDate ?? 'Not selected'}'),
                      ElevatedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _endDate = selectedDate;
                            });
                          }
                        },
                        child: const Text('END DATE'),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'DESCRIPTION OF CHALLENGE';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          _uploadData(context);
                        },
                        child: const Text('PUBLISH CHALLENGE'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
