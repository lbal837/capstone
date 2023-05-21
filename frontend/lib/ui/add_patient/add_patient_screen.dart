import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/data/user_repository.dart';
import 'package:frontend/secrets.dart';

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
            TextField(
              controller: _patientIdController,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                hintText: 'Enter Patient ID',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final completer = Completer<void>();
                try {
                  _subscribeToPatient().then((_) => _addPatientToUser())
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Patient successfully added and subscribed!')));
                    completer.complete();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Failed to add or subscribe patient!')));
                  completer.completeError(e);
                }
              },
              child: const Text('Subscribe to Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
