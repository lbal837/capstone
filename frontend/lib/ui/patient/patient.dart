import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/ui/patient/widgets/profile_header.dart';

class _PatientPageState extends State<PatientPage> {
  late Future<Patient> futurePatient;

  @override
  void initState() {
    //we may have a problem with reloading data w init
    super.initState();
    futurePatient = fetchPatient(); //we could put user id here i think
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
  State<PatientPage> createState() => _PatientPageState();
}
