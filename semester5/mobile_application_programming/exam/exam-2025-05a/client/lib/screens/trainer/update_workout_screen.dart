import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/core/api_service.dart';

class UpdateWorkoutScreen extends StatefulWidget {
  final Workout workout;

  UpdateWorkoutScreen({required this.workout});

  @override
  _UpdateWorkoutScreenState createState() => _UpdateWorkoutScreenState();
}

class _UpdateWorkoutScreenState extends State<UpdateWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String trainer;
  late String description;
  late String status;
  late int participants;
  late String type;
  late int duration;

  final List<String> workoutTypes = [
    'strength training',
    'cardio',
    'yoga',
    'pilates',
    'HIIT',
  ];

  @override
  void initState() {
    super.initState();
    name = widget.workout.name;
    trainer = widget.workout.trainer;
    description = widget.workout.description;
    status = widget.workout.status;
    participants = widget.workout.participants;
    type = widget.workout.type;
    duration = widget.workout.duration;
  }

  Future<void> _updateWorkout() async {
    if (_formKey.currentState!.validate()) {
      Workout updatedWorkout = Workout(
        id: widget.workout.id,
        name: name,
        trainer: trainer,
        description: description,
        status: status,
        participants: participants,
        type: type,
        duration: duration,
      );

      try {
        await ApiService.updateWorkout(updatedWorkout);
        Navigator.pop(context, true); // ✅ Return true to refresh the list
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating workout')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Workout')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Workout Name'),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                initialValue: trainer,
                decoration: InputDecoration(labelText: 'Trainer Name'),
                onChanged: (value) => trainer = value,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
              TextFormField(
                initialValue: participants.toString(),
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
                initialValue: duration.toString(),
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
                onPressed: _updateWorkout,
                child: Text('Update Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
