class JobPostModel {
  final String userId; // This field represents the user ID

  // Other fields for your job posting model
  final DateTime startDate;
  final DateTime endDate;
  final double salary;
  final String location;
  final String description;

  JobPostModel({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.salary,
    required this.location,
    required this.description,
  });

  // Convert the model to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      'salary': salary,
      'location': location,
      'description': description,
    };
  }
}
