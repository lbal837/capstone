import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/add_patient/widget/add_patient_button.dart';
import 'package:frontend/ui/add_patient/widget/add_patient_id.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  AddPatientScreenState createState() => AddPatientScreenState();
}

class AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _patientIdController = TextEditingController();
  final UserService _userService = UserService(userPool);
  final UserRepository userRepository = UserDefaultRepository();

  Future<void> _subscribeToPatient() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _patientIdController.text.toUpperCase();

    final caregiverEmail = caregiver?.email;
    await userRepository.subscribeToPatient(caregiverEmail!, patientId);
  }

  Future<void> _addPatientToUser() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _patientIdController.text.toUpperCase();

    final caregiverEmail = caregiver?.email;
    await userRepository.addPatientToUser(caregiverEmail!, patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddPatientId(controller: _patientIdController),
            const SizedBox(height: 16.0),
            AddPatientButton(
              subscribeToPatient: _subscribeToPatient,
              addPatientToUser: _addPatientToUser,
            ),
          ],
        ),
      ),
    );
  }
}
