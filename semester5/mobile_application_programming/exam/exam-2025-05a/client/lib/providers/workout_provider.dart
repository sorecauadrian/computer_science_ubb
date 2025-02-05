import 'package:flutter/material.dart';
import 'package:client/models/workout.dart';
import 'package:client/core/api_service.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Workout> get workouts => _workouts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch workouts and update state
  Future<void> fetchWorkouts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _workouts = await ApiService.getWorkouts();
      _errorMessage = null;
    } catch (error) {
      _errorMessage = 'Failed to fetch workouts';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create a new workout
  Future<void> addWorkout(Workout workout) async {
    try {
      final newWorkout = await ApiService.createWorkout(workout);
      _workouts.add(newWorkout);
      notifyListeners();
    } catch (error) {
      _errorMessage = 'Failed to create workout';
    }
  }

  // Update an existing workout
  Future<void> updateWorkout(Workout workout) async {
    try {
      final updatedWorkout = await ApiService.updateWorkout(workout);
      int index = _workouts.indexWhere((w) => w.id == workout.id);
      if (index != -1) {
        _workouts[index] = updatedWorkout;
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'Failed to update workout';
    }
  }
}
