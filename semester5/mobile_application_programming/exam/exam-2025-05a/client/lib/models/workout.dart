class Workout {
  final int id;
  final String name;
  final String trainer;
  final String description;
  final String status;
  final int participants;
  final String type;
  final int duration;

  Workout({
    required this.id,
    required this.name,
    required this.trainer,
    required this.description,
    required this.status,
    required this.participants,
    required this.type,
    required this.duration,
  });

  // Factory constructor to create a Workout object from JSON
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      trainer: json['trainer'],
      description: json['description'],
      status: json['status'],
      participants: json['participants'],
      type: json['type'],
      duration: json['duration'],
    );
  }

  // Method to convert a Workout object into JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'trainer': trainer,
      'description': description,
      'status': status,
      'participants': participants,
      'type': type,
      'duration': duration,
    };
  }
}
