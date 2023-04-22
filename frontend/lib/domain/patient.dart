class Patient {
  final String userId;
  final String avatarImage;
  final String fullName;
  final String longitude;
  final String latitude;
  final String dateTime;
  final double heartRate;
  final double steps;
  final String sleepStatus;

  const Patient({
    required this.userId,
    required this.avatarImage,
    required this.fullName,
    required this.longitude,
    required this.latitude,
    required this.dateTime,
    required this.heartRate,
    required this.steps,
    required this.sleepStatus,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      userId: json['UserId'],
      avatarImage: json['AvatarImage'],
      fullName: json['FullName'],
      longitude: json['Longitude'],
      latitude: json['Latitude'],
      dateTime: json['DateTime'],
      heartRate: json['HeartRate'],
      steps: json['Steps'],
      sleepStatus: json['SleepStatus'],
    );
  }

  @override
  String toString() {
    return 'Patient(userId: $userId, avatarImage: $avatarImage, fullName: $fullName, '
        'longitude: $longitude, latitude: $latitude, dateTime: $dateTime, '
        'heartRate: $heartRate, steps: $steps, sleepStatus: $sleepStatus)';
  }
}
