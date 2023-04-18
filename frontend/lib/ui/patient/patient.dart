import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class _MyDataPageState extends State<MyDataPage> {
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
        title: const Text('data page'),
      ),
      body: ListView(
        children: [
          ProfileHeader(),
        ],
      ),
    );
  }
}

class MyDataPage extends StatefulWidget {
  const MyDataPage({super.key, required this.title});
  final String title;
  @override
  State<MyDataPage> createState() => _MyDataPageState();
}