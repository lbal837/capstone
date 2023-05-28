import 'package:flutter/material.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/patient_data/widgets/heart_rate_profile_header.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_location.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_profile_header.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_sleep.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_step_count.dart';
import 'package:intl/intl.dart';

class PatientDataScreenState extends State<PatientDataScreen> {
  Patient? patient;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final UserRepository userRepository = UserDefaultRepository();
    patient = await userRepository.fetchPatient(widget.userId);
    if (patient != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  bool isWithinOneMinute(String dateTimeString) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    final dateTime = format.parseUtc(dateTimeString);
    final now = DateTime.now().toUtc().add(const Duration(hours: 12));
    final difference = now.difference(dateTime);
    return difference.inSeconds.abs() < 60;
  }

  void navigateToMapScreen(double latitude, double longitude) {
    Navigator.pushNamed(context, '/patientLocation', arguments: {
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Data Page'),
        ),
        body: ListView(
          children: <Widget>[
            ProfileHeader(
              name: patient?.fullName,
              picture: patient?.avatarImage,
              isConnected: isWithinOneMinute(patient!.dateTime),
            ),
            HeartRateWidget(heartRate: patient?.heartRate.toString()),
            GPSWidget(
              latitude: patient?.latitude,
              longitude: patient?.longitude,
            ),
            StepCountWidget(stepCount: patient?.steps),
            Sleep(sleepStatus: patient?.sleepStatus),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Data Page'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

class PatientDataScreen extends StatefulWidget {
  const PatientDataScreen({super.key, required this.userId});

  final String userId;

  @override
  State<PatientDataScreen> createState() => PatientDataScreenState();
}
