import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/core/api_service.dart';

class TopWorkoutsScreen extends StatefulWidget {
  @override
  _TopWorkoutsScreenState createState() => _TopWorkoutsScreenState();
}

class _TopWorkoutsScreenState extends State<TopWorkoutsScreen> {
  List<Workout> workouts = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchTopWorkouts();
  }

  Future<void> fetchTopWorkouts() async {
    try {
      final fetchedWorkouts = await ApiService.getAllWorkouts();

      // ✅ Sorting by status (ascending) and participants (descending)
      fetchedWorkouts.sort((a, b) {
        int statusComparison = a.status.compareTo(b.status);
        return statusComparison != 0
            ? statusComparison
            : b.participants.compareTo(a.participants);
      });

      setState(() {
        workouts = fetchedWorkouts.take(5).toList(); // ✅ Keep only top 5
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = "Failed to load analytics";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top 5 Workouts')),
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
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  '${index + 1}',
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
                  Text("Status: ${workout.status}"),
                  Text("Duration: ${workout.duration} min"),
                ],
              ),
              trailing: Text(
                "Participants: ${workout.participants}",
                style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
