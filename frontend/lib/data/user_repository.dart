import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<List<Patient>> fetchUsersPatients();

  Future<void> addUserPatient(String userId, String patientId);
}

class UserDefaultRepository extends UserRepository {
  @override
  Future<List<Patient>> fetchUsersPatients() async {
    final response =
        await http.get(Uri.parse('$apiEndpoint/GetAllPatientData'), headers: {
      'x-api-key': apiKey,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<Patient> patients = [];
      for (final patient in jsonResponse['data']) {
        patients.add(Patient.fromJson(patient));
      }
      return patients;
    } else {
      debugPrint(
          'Error: status code ${response.statusCode}, response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<void> addUserPatient(String userId, String patientId) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint/AddPatientToUser'),
      headers: {'x-api-key': apiKey, 'Content-type': 'application/json'},
      body: jsonEncode(<String, String>{
        'UserId': userId,
        'PatientId': patientId,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint('Patient added to user');
    } else {
      debugPrint(
          'Error: status code ${response.statusCode}, response body: ${response.body}');
      throw Exception('Failed to add patient to user');
    }
  }
}
