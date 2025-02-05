import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/core/api_service.dart';

class AvailableWorkoutsScreen extends StatefulWidget {
  @override
  _AvailableWorkoutsScreenState createState() => _AvailableWorkoutsScreenState();
}

class _AvailableWorkoutsScreenState extends State<AvailableWorkoutsScreen> {
  List<Workout> workouts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchAvailableWorkouts();
  }

  Future<void> fetchAvailableWorkouts() async {
    try {
      final fetchedWorkouts = await ApiService.getAllWorkouts();
      setState(() {
        // ✅ Filter "in progress" workouts on client-side
        workouts = fetchedWorkouts.where((w) => w.status == "in progress").toList();
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Failed to load workouts";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User: Available Workouts')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(
                workout.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Duration: ${workout.duration} min"),
                  Text("Status: ${workout.status}"), // ✅ Now displays status
                ],
              ),
              trailing: Text(
                "Participants: ${workout.participants}",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          );
        },
      ),
    );
  }
}
