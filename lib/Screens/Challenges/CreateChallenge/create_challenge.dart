import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
              content: Text('Workout challenge created successfully!')),
        );
      } catch (error) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create workout challenge. $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Workout Challenge'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      return 'Please enter the title';
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
                      return 'Please enter the type of workout';
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
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _startDate = selectedDate;
                      });
                    }
                  },
                  child: const Text('Select Start Date'),
                ),
                const SizedBox(height: 16.0),
                Text('End Date: ${_endDate ?? 'Not selected'}'),
                ElevatedButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _endDate = selectedDate;
                      });
                    }
                  },
                  child: const Text('Select End Date'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _uploadData(context);
                  },
                  child: const Text('Create Workout Challenge'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
