import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/response.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/add_patient/widget/add_patient_button.dart';
import 'package:frontend/ui/add_patient/widget/add_patient_id.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  AddPatientScreenState createState() => AddPatientScreenState();
}

class AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _addPatientIdController = TextEditingController();
  final UserService _userService = UserService(userPool);
  final UserRepository userRepository = UserDefaultRepository();

  Future<Response> _subscribeToPatient() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _addPatientIdController.text.toUpperCase();

    final caregiverEmail = caregiver?.email;

    return userRepository.subscribeToPatient(caregiverEmail!, patientId);
  }

  Future<Response> _addPatientToUser() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _addPatientIdController.text.toUpperCase();

    final caregiverEmail = caregiver?.email;

    return userRepository.addPatientToUser(caregiverEmail!, patientId);
  }

  @override
  void dispose() {
    _addPatientIdController.dispose();
    super.dispose();
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
            AddPatientId(controller: _addPatientIdController),
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
