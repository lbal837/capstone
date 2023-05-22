import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/secrets.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<List<Patient>> fetchUserPatients(String caregiverEmail);

  Future<bool> addPatientToUser(String userId, String patientId);

  Future<bool> subscribeToPatient(String caregiverEmail, String patientId);

  Future<Patient> fetchPatient(String id);
}

class UserDefaultRepository extends UserRepository {
  @override
  Future<Patient> fetchPatient(String id) async {
    final response = await http
        .get(Uri.parse('$apiEndpoint/GetPatientData?UserId=$id'), headers: {
      'x-api-key': apiKey,
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final Patient patient = Patient.fromJson(jsonResponse['data']);
      return patient;
    } else {
      debugPrint(
          'Error: status code ${response.statusCode}, response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<List<Patient>> fetchUserPatients(String caregiverEmail) async {
    final response = await http.get(
        Uri.parse('$apiEndpoint/GetUserPatients?UserId=$caregiverEmail'),
        headers: {
          'x-api-key': apiKey,
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> patientIds = jsonResponse['data'];

      final List<Future<Patient>> patientFutures = patientIds
          .map((patientId) => fetchPatient(patientId.toString()))
          .toList();

      final List<Patient> patients = await Future.wait(patientFutures);

      return patients;
    } else {
      debugPrint(
          'Error: status code ${response.statusCode}, response body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<bool> addPatientToUser(String userId, String patientId) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint/AddUserToPatientv2'),
      headers: {'x-api-key': apiKey, 'Content-type': 'application/json'},
      body: jsonEncode(<String, String>{
        'UserId': userId,
        'PatientId': patientId,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint('Patient added to user');
      return true;
    } else {
      debugPrint(
          'Error: status code ${response.statusCode}, response body: ${response.body}');
      return false;
    }
  }

  @override
  Future<bool> subscribeToPatient(
      String caregiverEmail, String patientId) async {
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
        return true;
      } else {
        debugPrint(
            'Failed to subscribe to patient. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      debugPrint('Failed to subscribe to patient: $e');
      return false;
    }
  }
}
