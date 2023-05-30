import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:frontend/domain/patient.dart';
import 'package:frontend/domain/response.dart';
import 'package:frontend/secrets.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<List<Patient>> fetchUserPatients(String caregiverEmail);

  Future<Response> addPatientToUser(String userId, String patientId);

  Future<Response> removePatientFromUser(String userId, String patientId);

  Future<Response> subscribeToPatient(String caregiverEmail, String patientId);

  Future<Response> unsubscribeFromPatient(
    String caregiverEmail,
    String patientId,
  );

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
        'Error: status code ${response.statusCode}, response body: ${response.body}',
      );
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<List<Patient>> fetchUserPatients(String caregiverEmail) async {
    final response = await http.get(
      Uri.parse('$apiEndpoint/GetUserPatients?UserId=$caregiverEmail'),
      headers: {
        'x-api-key': apiKey,
      },
    );

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
        'Error: status code ${response.statusCode}, response body: ${response.body}',
      );
      throw Exception('Failed to load data');
    }
  }

  @override
  Future<Response> addPatientToUser(String userId, String patientId) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint/AddUserToPatientv2'),
      headers: {'x-api-key': apiKey, 'Content-type': 'application/json'},
      body: jsonEncode(<String, String>{
        'UserId': userId,
        'PatientId': patientId,
      }),
    );

    final responseJson = jsonDecode(response.body);

    debugPrint(responseJson['message']);

    return Response(
      isSuccess: response.statusCode == 200,
      message: responseJson['message'],
    );
  }

  @override
  Future<Response> subscribeToPatient(
    String caregiverEmail,
    String patientId,
  ) async {
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

      final responseJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        debugPrint(responseJson['message']);

        return Response(isSuccess: true, message: responseJson['message']);
      } else {
        debugPrint(
          'Failed to subscribe to patient. Status code: ${response.statusCode}. Message: ${responseJson['message']}',
        );

        return Response(isSuccess: false, message: responseJson['message']);
      }
    } catch (e) {
      debugPrint('Failed to subscribe to patient: $e');

      return Response(
        isSuccess: false,
        message: 'Failed to subscribe to patient: $e',
      );
    }
  }

  @override
  Future<Response> removePatientFromUser(
    String userId,
    String patientId,
  ) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint/RemovePatientFromCaregiver'),
      headers: {'x-api-key': apiKey, 'Content-type': 'application/json'},
      body: jsonEncode(<String, String>{
        'UserId': userId,
        'PatientId': patientId,
      }),
    );

    final responseJson = jsonDecode(response.body);

    debugPrint(responseJson['message']);

    return Response(
      isSuccess: response.statusCode == 200,
      message: responseJson['message'],
    );
  }

  @override
  Future<Response> unsubscribeFromPatient(
    String caregiverEmail,
    String patientId,
  ) async {
    const apiUrl = '$apiEndpoint/UnsubscribeCaregiverFromPatient';

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

      final responseJson = jsonDecode(response.body);
      debugPrint(responseJson['message']);

      return Response(
        isSuccess: response.statusCode == 200,
        message: responseJson['message'],
      );
    } catch (e) {
      debugPrint('Failed to unsubscribe from patient: $e');

      return Response(
        isSuccess: false,
        message: 'Failed to unsubscribe from patient: $e',
      );
    }
  }
}
