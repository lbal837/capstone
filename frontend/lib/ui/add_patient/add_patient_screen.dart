import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/auth/user_service.dart';
import 'package:frontend/secrets.dart';
import 'package:http/http.dart' as http;

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  AddPatientScreenState createState() => AddPatientScreenState();
}

class AddPatientScreenState extends State<AddPatientScreen> {
  final TextEditingController _patientIdController = TextEditingController();
  final UserService _userService = UserService(userPool);

  Future<void> _subscribeToPatient() async {
    final caregiver = await _userService.getCurrentUser();
    final patientId = _patientIdController.text;

    final caregiverEmail = caregiver?.email;

    const apiUrl = '$apiEndpoint/SubscribeCaregiverToPatient';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'caregiver_email': caregiverEmail,
          'patient_id': patientId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': apiKey,
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Subscribed to patient with ID: $patientId');
      } else {
        debugPrint(
            'Failed to subscribe to patient. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Failed to subscribe to patient: $e');
    }
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
              onPressed: _subscribeToPatient,
              child: const Text('Subscribe to Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
