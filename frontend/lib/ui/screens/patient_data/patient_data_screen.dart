import 'package:flutter/material.dart';
import 'package:frontend/data/patient_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/screens/patient_data/widgets/patient_data_heart_rate_profile_header.dart';
import 'package:frontend/ui/screens/patient_data/widgets/patient_data_location.dart';
import 'package:frontend/ui/screens/patient_data/widgets/patient_data_profile_header.dart';
import 'package:frontend/ui/screens/patient_data/widgets/patient_data_sleep.dart';
import 'package:frontend/ui/screens/patient_data/widgets/patient_data_step_count.dart';

class _PatientInfoPageState extends State<PatientPage> {
  //late Future<Patient> futurePatient;
  //late Future<List<Patient>> futurePatients;
  Patient? patient;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final PatientDefaultRepository patientRepository =
        PatientDefaultRepository();
    patient = await patientRepository.fetchPatient(widget.userid!);
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
          children: <Widget>[
            ProfileHeader(
                name: patient?.fullName, picture: patient?.avatarImage),
            HeartRateWidget(heartRate: patient?.heartRate.toString()),
            GPSWidget(
                latitude: patient?.latitude, longitude: patient?.longitude),
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
          ));
    }
  }
}

class PatientPage extends StatefulWidget {
  const PatientPage({super.key, required this.title, this.userid});

  final String title;
  final String? userid;

  @override
  State<PatientPage> createState() => _PatientInfoPageState();
}
