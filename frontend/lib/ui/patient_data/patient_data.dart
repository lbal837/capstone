import 'package:flutter/material.dart';
import 'package:frontend/data/patient_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/patient_data/widgets/heart_rate_profile_header.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_location.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_profile_header.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_sleep.dart';
import 'package:frontend/ui/patient_data/widgets/patient_data_step_count.dart';

class _PatientInfoPageState extends State<PatientPage> {
  //late Future<Patient> futurePatient;
  //late Future<List<Patient>> futurePatients;
  Patient? patient;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final PatientDefaultRepository patientRepository =
        PatientDefaultRepository();
    patient = await patientRepository.fetchPatient('BHL33M');
    if (patient != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoaded) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Data Page'),
        ),
        body:
            //final patient_name = patient.fullName,
            ListView(
          children: [
            ProfileHeader(name: patient?.fullName),
            HeartRateWidget(heartrate: patient?.heartRate.toString()),
            GPSWidget(
                latitude: patient?.latitude, longitude: patient?.longitude),
            StepCountWidget(stepCount: patient?.steps),
            SleepWidget(sleepStatus: patient?.sleepStatus),
          ],
        ),
      );
    } else {
      return Scaffold();
    }
  }
}

class PatientPage extends StatefulWidget {
  const PatientPage({super.key, required this.title});

  final String title;

  @override
  State<PatientPage> createState() => _PatientInfoPageState();
}
