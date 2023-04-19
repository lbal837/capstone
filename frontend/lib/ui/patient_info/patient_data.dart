import 'package:flutter/material.dart';
import 'package:frontend/data/patient_repository.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/ui/patient_info/widgets/patient_data_profile_header.dart';

class _PatientInfoPageState extends State<PatientPage> {
  late Future<Patient> futurePatient;

  @override
  void initState() {
    //we may have a problem with reloading data w init
    super.initState();
    final PatientDefaultRepository patientRepository =
        PatientDefaultRepository();
    futurePatient = patientRepository
        .fetchPatient('BHL33M'); //we could put user id here i think
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Page'),
      ),
      body: ListView(
        children: const [
          ProfileHeader(),
        ],
      ),
    );
  }
}

class PatientPage extends StatefulWidget {
  const PatientPage({super.key, required this.title});

  final String title;

  @override
  State<PatientPage> createState() => _PatientInfoPageState();
}
