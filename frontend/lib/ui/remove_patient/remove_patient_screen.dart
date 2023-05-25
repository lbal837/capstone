import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/domain/response.dart';
import 'package:frontend/secrets.dart';
import 'package:frontend/ui/remove_patient/widget/remove_patient_button.dart';
import 'package:frontend/ui/remove_patient/widget/remove_patient_id.dart';

class RemovePatientScreen extends StatefulWidget {
  const RemovePatientScreen({Key? key}) : super(key: key);

  @override
  RemovePatientScreenState createState() => RemovePatientScreenState();
}

class RemovePatientScreenState extends State<RemovePatientScreen> {
  final TextEditingController _patientIdController = TextEditingController();
  final UserService _userService = UserService(userPool);
  final UserRepository userRepository = UserDefaultRepository();

  Future<Response> _unsubscribeFromPatient() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _patientIdController.text.toUpperCase();

    final caregiverEmail = caregiver?.email;
    return userRepository.unsubscribeFromPatient(caregiverEmail!, patientId);
  }

  Future<Response> _removePatientFromUser() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _patientIdController.text.toUpperCase();

    final caregiverEmail = caregiver?.email;
    return userRepository.removePatientFromUser(caregiverEmail!, patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remove Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RemovePatientId(controller: _patientIdController),
            RemovePatientButton(
              unsubscribeFromPatient: _unsubscribeFromPatient,
              removePatientFromUser: _removePatientFromUser,
            ),
          ],
        ),
      ),
    );
  }
}
