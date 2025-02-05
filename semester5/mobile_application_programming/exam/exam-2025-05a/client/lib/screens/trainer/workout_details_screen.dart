import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/screens/trainer/update_workout_screen.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final Workout workout;

  WorkoutDetailsScreen({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(workout.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trainer: ${workout.trainer}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Description: ${workout.description}'),
            SizedBox(height: 10),
            Text('Status: ${workout.status}'),
            SizedBox(height: 10),
            Text('Participants: ${workout.participants}'),
            SizedBox(height: 10),
            Text('Type: ${workout.type}'),
            SizedBox(height: 10),
            Text('Duration: ${workout.duration} min'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateWorkoutScreen(workout: workout),
                    ),
                  );

                  if (result == true) {
                    Navigator.pop(context, true); // ✅ Return true to refresh the list
                  }
                },
                child: Text('Edit Workout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
