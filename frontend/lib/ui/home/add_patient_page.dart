import 'package:flutter/material.dart';

class addPatientScreen extends StatelessWidget {
  const addPatientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Hero(tag: 'uniqueTag', child: Icon(Icons.save)),
      ),
    );
  }
}