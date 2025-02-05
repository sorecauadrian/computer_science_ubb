import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/models/workout.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.52:2505';

  // Fetch all workouts (Trainer View)
  static Future<List<Workout>> getWorkouts() async {
    final response = await http.get(Uri.parse('$baseUrl/workouts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }

  // Fetch all workouts (User & Analytics View)
  static Future<List<Workout>> getAllWorkouts() async {
    final response = await http.get(Uri.parse('$baseUrl/allWorkouts'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load all workouts');
    }
  }

  // Fetch workout details by ID
  static Future<Workout> getWorkoutById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/workout/$id'));

    if (response.statusCode == 200) {
      return Workout.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Workout not found');
    }
  }

  // Create a new workout
  static Future<Workout> createWorkout(Workout workout) async {
    final response = await http.post(
      Uri.parse('$baseUrl/workout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(workout.toJson()),
    );

    if (response.statusCode == 201) {
      return Workout.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create workout');
    }
  }

  // Update an existing workout
  static Future<Workout> updateWorkout(Workout workout) async {
    final response = await http.put(
      Uri.parse('$baseUrl/workout'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(workout.toJson()),
    );

    if (response.statusCode == 200) {
      return Workout.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update workout');
    }
  }
}
