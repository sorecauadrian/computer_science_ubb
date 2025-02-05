import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/core/api_service.dart';

class CreateWorkoutScreen extends StatefulWidget {
  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String trainer = '';
  String description = '';
  String status = 'planned';
  int participants = 0;
  String type = 'strength training'; // Default type
  int duration = 0;

  final List<String> workoutTypes = [
    'strength training',
    'cardio',
    'yoga',
    'pilates',
    'HIIT',
  ];

  Future<void> _submitWorkout() async {
    if (_formKey.currentState!.validate()) {
      Workout newWorkout = Workout(
        id: 0,
        name: name,
        trainer: trainer,
        description: description,
        status: status,
        participants: participants,
        type: type,
        duration: duration,
      );

      try {
        await ApiService.createWorkout(newWorkout);
        Navigator.pop(context, true); // ✅ Return true to refresh the list
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating workout')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Workout')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Workout Name'),
                onChanged: (value) => name = value,
                validator: (value) => value!.isEmpty ? 'Enter workout name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Trainer Name'),
                onChanged: (value) => trainer = value,
                validator: (value) => value!.isEmpty ? 'Enter trainer name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
                validator: (value) => value!.isEmpty ? 'Enter description' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Participants'),
                keyboardType: TextInputType.number,
                onChanged: (value) => participants = int.tryParse(value) ?? 0,
              ),
              DropdownButtonFormField<String>(
                value: workoutTypes.contains(type) ? type : null, // ✅ Ensure value exists
                decoration: InputDecoration(labelText: 'Workout Type'),
                items: workoutTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  type = value!;
                }),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => duration = int.tryParse(value) ?? 0,
              ),
              DropdownButtonFormField<String>(
                value: ['planned', 'in progress', 'completed'].contains(status) ? status : null, // ✅ Ensure value exists
                decoration: InputDecoration(labelText: 'Status'),
                items: ['planned', 'in progress', 'completed'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) => setState(() {
                  status = value!;
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitWorkout,
                child: Text('Create Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
