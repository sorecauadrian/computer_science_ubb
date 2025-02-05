import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/core/api_service.dart';
import 'package:client/screens/trainer/workout_details_screen.dart';
import 'package:client/screens/trainer/create_workout_screen.dart';

class WorkoutListScreen extends StatefulWidget {
  @override
  _WorkoutListScreenState createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  List<Workout> workouts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    try {
      final fetchedWorkouts = await ApiService.getWorkouts();
      setState(() {
        workouts = fetchedWorkouts;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Failed to load workouts. Please check your connection.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trainer: Workout Plans')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!, textAlign: TextAlign.center),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchWorkouts, // ✅ Retry button if offline
              child: Text("Retry"),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  '${workout.id}', // ✅ Show Workout ID
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                workout.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Trainer: ${workout.trainer}"),
                  Text("Type: ${workout.type}"),
                ],
              ),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkoutDetailsScreen(workout: workout),
                  ),
                );

                if (result == true) { // ✅ Refresh if updated
                  fetchWorkouts();
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateWorkoutScreen()),
          );

          if (result == true) {  // ✅ Refresh list after adding workout
            fetchWorkouts();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
